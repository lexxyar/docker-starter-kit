import os
import uvicorn

from dotenv import load_dotenv
from fastapi import FastAPI

load_dotenv()

app = FastAPI()

port = int(os.getenv("HTTP_PORT", "7000"))

@app.get("/")
async def root():
    return {"message": "Hello World"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=port)
