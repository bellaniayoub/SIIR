from fastapi import APIRouter, HTTPException, status, Depends
from pydantic import BaseModel
from google.oauth2 import id_token
from google.auth.transport import requests
from sqlalchemy.orm import Session
import jwt
import datetime
import os

from app.db.database import get_db
from app.db.models import User
from app.schemas.user import UserOut

router = APIRouter()

# Secret key for JWT token signing
JWT_SECRET = os.getenv("JWT_SECRET", "siir_morocco_car_rental_secret_key_2026")
JWT_ALGORITHM = os.getenv("JWT_ALGORITHM", "HS256")

class GoogleAuthRequest(BaseModel):
    id_token: str
    role_preference: str  # Must be 'Client' or 'Agency'

@router.post("/google")
async def authenticate_google(payload: GoogleAuthRequest, db: Session = Depends(get_db)):
    if payload.role_preference not in ["Client", "Agency"]:
        raise HTTPException(
            status_code=status.HTTP_400_BAD_REQUEST,
            detail="Role preference must be 'Client' or 'Agency'"
        )

    user_profile = None

    # Handle local debugging/testing bypass
    if payload.id_token.startswith("mock-"):
        user_profile = {
            "email": f"test_{payload.role_preference.lower()}@siir.ma",
            "name": f"Test {payload.role_preference}",
            "picture": "https://lh3.googleusercontent.com/a/mock_pic_url",
            "sub": f"mock-google-sub-id-{payload.role_preference.lower()}"
        }
    else:
        try:
            # Verify OAuth2 Google token signature and claim
            request_transport = requests.Request()
            idinfo = id_token.verify_oauth2_token(
                payload.id_token, 
                request_transport, 
                audience=None  # Set to your Client ID in production
            )
            
            user_profile = {
                "email": idinfo.get("email"),
                "name": idinfo.get("name"),
                "picture": idinfo.get("picture"),
                "sub": idinfo.get("sub")
            }
        except ValueError as e:
            raise HTTPException(
                status_code=status.HTTP_401_UNAUTHORIZED,
                detail=f"Invalid Google ID Token: {str(e)}"
            )

    assigned_role = payload.role_preference
    now = datetime.datetime.now(datetime.timezone.utc)

    # PostgreSQL Database User Persistence (Upsert)
    try:
        user_db = db.query(User).filter(
            (User.google_sub == user_profile["sub"]) | (User.email == user_profile["email"])
        ).first()

        if user_db:
            # Existing user - update profile info & last login timestamp
            user_db.last_login = now
            user_db.role = assigned_role
            if user_profile["name"]:
                user_db.name = user_profile["name"]
            if user_profile["picture"]:
                user_db.picture = user_profile["picture"]
            if not user_db.google_sub:
                user_db.google_sub = user_profile["sub"]
        else:
            # New user - insert into PostgreSQL
            user_db = User(
                google_sub=user_profile["sub"],
                email=user_profile["email"],
                name=user_profile["name"],
                picture=user_profile["picture"],
                role=assigned_role,
                created_at=now,
                last_login=now
            )
            db.add(user_db)

        db.commit()
        db.refresh(user_db)
        user_id = user_db.id
    except Exception as db_err:
        db.rollback()
        print(f"[Database Error] User persistence failed: {db_err}")
        user_id = 1  # Fallback for dev mode

    # Generate JWT Session Token with database user ID
    expiration = now + datetime.timedelta(hours=24)
    jwt_payload = {
        "user_id": user_id,
        "sub": user_profile["sub"],
        "email": user_profile["email"],
        "role": assigned_role,
        "exp": expiration
    }
    
    session_token = jwt.encode(jwt_payload, JWT_SECRET, algorithm=JWT_ALGORITHM)

    return {
        "status": "success",
        "message": "Authentication successful",
        "role_assigned": assigned_role,
        "token": session_token,
        "user": {
            "id": user_id,
            "email": user_profile["email"],
            "name": user_profile["name"],
            "picture": user_profile["picture"],
            "role": assigned_role
        }
    }

