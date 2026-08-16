from pydantic import BaseModel, ConfigDict
from typing import Optional
from datetime import datetime

class UserBase(BaseModel):
    email: str
    name: Optional[str] = None
    picture: Optional[str] = None
    role: str = "Client"

class UserCreate(UserBase):
    google_sub: Optional[str] = None

class UserOut(UserBase):
    id: int
    google_sub: Optional[str] = None
    created_at: datetime
    last_login: datetime

    model_config = ConfigDict(from_attributes=True)
