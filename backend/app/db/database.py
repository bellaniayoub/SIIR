import os
from dotenv import load_dotenv
from sqlalchemy import create_engine
from sqlalchemy.orm import sessionmaker, DeclarativeBase

# Load environment variables from .env if present
load_dotenv()

# PostgreSQL Connection URL
DEFAULT_DB_URL = "postgresql://postgres:postgres@localhost:5432/siir_db"
DATABASE_URL = os.getenv("DATABASE_URL", DEFAULT_DB_URL)

# Fallback to SQLite local file if PostgreSQL is unavailable during local dev without PG server
SQLITE_FALLBACK_URL = "sqlite:///./siir_dev_fallback.db"

def get_engine():
    try:
        engine = create_engine(DATABASE_URL, pool_pre_ping=True)
        # Quick test connection
        with engine.connect() as conn:
            pass
        print(f"[Database] Connected to PostgreSQL at {DATABASE_URL}")
        return engine
    except Exception as e:
        print(f"[Database Warning] Could not connect to PostgreSQL ({e}). Falling back to SQLite dev database.")
        engine = create_engine(SQLITE_FALLBACK_URL, connect_args={"check_same_thread": False})
        return engine

engine = get_engine()
SessionLocal = sessionmaker(autocommit=False, autoflush=False, bind=engine)

class Base(DeclarativeBase):
    pass

def get_db():
    db = SessionLocal()
    try:
        yield db
    finally:
        db.close()
