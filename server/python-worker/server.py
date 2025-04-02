from flask import Flask, request, jsonify
import redis
import os

app = Flask(__name__)
redis_client = redis.Redis.from_url(os.getenv("REDIS_URL"))

@app.route('/process', methods=['POST'])
def process_message():
    data = request.json
    message = data['message']
    processed_message = message.upper()  
    redis_client.rpush("chat_processed", processed_message)
    return jsonify({'processed_message': processed_message})

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5001)
