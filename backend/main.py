from fastapi import FastAPI, HTTPException
from pydantic import BaseModel

app = FastAPI()

# Dummy login credentials
VALID_EMAIL = "someone@gmail.com"
VALID_PASSWORD = "123456"

# Dummy user data
users_data = {
    "id1": [{"name": "Alice", "parent's phone": "1234567890", "phonenumber": None, "address": None, "details": None}],
    "id2": [{"name": "Bob", "parent's phone": "0987654321", "phonenumber": None, "address": None, "details": None}],
    "id3": [{"name": "Charlie", "parent's phone": "1122334455", "phonenumber": None, "address": None, "details": None}],
    "id4": [{"name": "David", "parent's phone": "5566778899", "phonenumber": None, "address": None, "details": None}],
    "id5": [{"name": "Eve", "parent's phone": "6677889900", "phonenumber": None, "address": None, "details": None}],
    "id6": [{"name": "Frank", "parent's phone": "7788990011", "phonenumber": None, "address": None, "details": None}],
    "id7": [{"name": "Grace", "parent's phone": "8899001122", "phonenumber": None, "address": None, "details": None}],
    "id8": [{"name": "Heidi", "parent's phone": "9900112233", "phonenumber": None, "address": None, "details": None}],
    "id9": [{"name": "Ivan", "parent's phone": "1011121314", "phonenumber": None, "address": None, "details": None}],
    "id10": [{"name": "Judy", "parent's phone": "1213141516", "phonenumber": None, "address": None, "details": None}],
    "id11": [{"name": "Ken", "parent's phone": "1415161718", "phonenumber": None, "address": None, "details": None}]
}

# Request body for login
class LoginRequest(BaseModel):
    email: str
    password: str

@app.post("/api/login")
def login(request: LoginRequest):
    if request.email == VALID_EMAIL and request.password == VALID_PASSWORD:
        return {"status": "success", "message": "Login successful"}
    raise HTTPException(status_code=401, detail="Invalid email or password")

@app.get("/api/show")
def show_api():
    return {"message": "API is working fine",
            "login_credentials": {
            "email": "someone@gmail.com",
            "password": "123456"
        }
            }

@app.get("/api/users")
def get_users():
    return users_data
