import os
from dotenv import load_dotenv, find_dotenv
import requests

load_dotenv(find_dotenv())

TOKEN = os.getenv("TOKEN")  # замените на ваш токен
CHAT_ID = os.getenv("CHAT_ID")  # замените на chat_id (int или строка "@channelusername")

TEXT = "Олег привет от ci cd бота и погнали в лол"

# Request messages
# url = f"https://api.telegram.org/bot{TOKEN}/getUpdates"

print(TOKEN)
url = f"https://api.telegram.org/bot{TOKEN}/sendMessage"
payload = {"chat_id": CHAT_ID, "text": TEXT, "parse_mode": "HTML"}

resp = requests.post(url, data=payload, timeout=10)
resp.raise_for_status()
print(resp.json())
