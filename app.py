import uvicorn
from fastapi import FastAPI
from datetime import datetime

app = FastAPI()

@app.get("/")
def get_current_time():
    current_time = datetime.now().strftime("%Y-%m-%d %H:%M:%S")
    return {"CurrentTime": current_time}

if __name__ == "__main__":
    uvicorn.run(app, port=8001, host="0.0.0.0")
