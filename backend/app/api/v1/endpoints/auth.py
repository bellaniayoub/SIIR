from fastapi import APIRouter, HTTPException, status
from pydantic import BaseModel
from google.oauth2 import id_token
from google.auth.transport import requests
import jwt
import datetime

router = APIRouter()

# Secret key for local mock JWT token signing
JWT_SECRET = "siir_morocco_car_rental_secret_key_2026"
JWT_ALGORITHM = "HS256"

class GoogleAuthRequest(BaseModel):
    id_token: str
    role_preference: str  # Must be 'Client' or 'Agency'

@router.post("/google")
async def authenticate_google(payload: GoogleAuthRequest):
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
            "sub": "mock-google-sub-id-12345"
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

    # Validate/Assign Role
    assigned_role = payload.role_preference

    # Generate mock JWT Session Token
    expiration = datetime.datetime.utcnow() + datetime.timedelta(hours=24)
    jwt_payload = {
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
            "email": user_profile["email"],
            "name": user_profile["name"],
            "picture": user_profile["picture"]
        }
    }
