# SIIR - Intelligent Car Rental Marketplace (Morocco)

SIIR is a digital marketplace connecting B2C clients (local citizens and international tourists) with B2B verified car rental agencies in Morocco, as specified in the business vision. 

The platform features a clean, separated architecture for the frontend and backend, incorporating a translation translation routing layer to eliminate communication language barriers.

---

## Key Features

1. **Intelligent Multilingual Chat**: Translates messages instantly in real-time (e.g., Client writes in Spanish, Agency receives in Arabic; Agency replies in Arabic, Client receives in Spanish).
2. **Moroccan Market Integration**: Localized search criteria supporting filtering by Moroccan cities, pricing in Dirhams (MAD/DH), and specifications (fuel type, transmission type).
3. **Verified Agency Portals**: B2B agencies gain access to professional fleet management dashboards.
4. **Google Sign-In Authentication**: Direct Google OAuth2 ID token verification on the backend with session management via signed JWTs.

---

## Directory Layout

```
SIIR/
├── frontend/             # Flutter (Dart) mobile app client
│   ├── lib/
│   │   ├── core/         # Saffron/Green themes and network client base
│   │   └── features/     # Auth, Fleet Search, and Chat components
│   └── pubspec.yaml      # Client configuration & dependency list
│
└── backend/              # FastAPI (Python) backend server
    ├── app/
    │   ├── api/          # Route handlers & Google Auth verification
    │   └── main.py       # FastAPI application and CORS setup
    └── requirements.txt  # Python package specifications
```

---

## Local Setup

### Backend (Python/FastAPI)

1. **Navigate to backend and create virtual environment**:
   ```bash
   cd backend
   python -m venv .venv
   ```
2. **Activate environment**:
   - **Windows (PowerShell)**: `.\.venv\Scripts\Activate.ps1`
   - **macOS/Linux**: `source .venv/bin/activate`
3. **Install packages**:
   ```bash
   pip install -r requirements.txt
   ```
4. **Run server**:
   ```bash
   uvicorn app.main:app --reload
   ```
   Interactive documentation will be available at [http://127.0.0.1:8000/docs](http://127.0.0.1:8000/docs).

### Frontend (Flutter)

1. **Navigate to frontend**:
   ```bash
   cd frontend
   ```
2. **Get dependencies**:
   ```bash
   flutter pub get
   ```
3. **Launch**:
   ```bash
   flutter run
   ```
