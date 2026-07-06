from fastapi import FastAPI
from fastapi.middleware.cors import CORSMiddleware
from app.api.v1.endpoints import auth

app = FastAPI(
    title="SIIR - Intelligent Car Rental Marketplace API",
    description="Backend API for B2C & B2B Car Rental in Morocco",
    version="1.0.0",
)

# Configure CORS for Flutter frontend integration
app.add_middleware(
    CORSMiddleware,
    allow_origins=["*"],  # Adjust in production environments
    allow_credentials=True,
    allow_methods=["*"],
    allow_headers=["*"],
)

# Register routers
app.include_router(
    auth.router,
    prefix="/api/v1/auth",
    tags=["Authentication"]
)

@app.get("/")
async def root():
    return {
        "app": "SIIR Car Rental Marketplace Backend",
        "version": "1.0.0",
        "status": "online",
        "documentation": "/docs"
    }
