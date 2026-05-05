FROM python:3.11-slim

# Install system libraries that opencv needs
RUN apt-get update && apt-get install -y \
    libgl1 \
    libglib2.0-0 \
    libxcb1 \
    libsm6 \
    libxext6 \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /app

COPY requirements.txt .

# Install Python packages in correct order
RUN pip install --upgrade pip
RUN pip install numpy==1.26.4
RUN pip install torch==2.1.0
RUN pip install mediapipe==0.10.9
RUN pip install --force-reinstall opencv-python-headless==4.8.1.78
RUN pip install flask flask-cors edge-tts

COPY . .

EXPOSE 5001

CMD ["python", "ai_server.py"]
