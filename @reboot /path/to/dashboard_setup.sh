from fastapi import FastAPI, Request, Header
import hmac
import hashlib
import uvicorn

app = FastAPI()

WEBHOOK_SECRET = "supersecurewebhooksecret"  # Same as entered in the form

def verify_signature(payload: bytes, signature: str):
    computed = hmac.new(WEBHOOK_SECRET.encode(), payload, hashlib.sha256).hexdigest()
    return hmac.compare_digest(computed, signature)

@app.post("/webhook")
async def coinbase_webhook(request: Request, x_webhook_signature: str = Header(None)):
    body = await request.body()

    if not verify_signature(body, x_webhook_signature):
        return {"status": "unauthorized"}

    data = await request.json()
    print("Received Smart Contract Event:", data)

    # TODO: Trigger task, send notification, etc.

    return {"status": "ok"}

if __name__ == "__main__":
    uvicorn.run(app, host="0.0.0.0", port=8000)