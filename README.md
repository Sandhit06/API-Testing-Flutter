### 🔧 Requirements

- Python 3.7+
- `pip` (Python package manager)
- Optional: Virtual Environment (`venv`)

---

### ✅ Installation

1. **Navigate to the backend folder**

```bash
cd backend
python -m venv venv
# Windows
.\venv\Scripts\activate
# macOS/Linux
source venv/bin/activate
```

2. **Install dependencies**
```bash
pip install -r requirements.txt
```
3. **Run the server**
```bash
uvicorn main:app --reload
```

- Server runs at: http://127.0.0.1:8000/
- Swagger UI: http://127.0.0.1:8000/docs
- ReDoc: http://127.0.0.1:8000/redoc

### 📡 API Endpoints
```bash
POST	/api/login	Login with email + password
GET	/api/show	Shows login credentials (demo)
GET	/api/users	Returns user data
```

### 🧪 Example Login Credentials
```bash
{
  "email": "someone@gmail.com",
  "password": "123456"
}
```
