# Use an official Python runtime as a parent image
FROM python:3.10-slim

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container at /app/backend
COPY backend/requirements.txt ./backend/

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir -r backend/requirements.txt

# Copy the rest of the application code into the container
COPY . .

# Create database and uploads directories
RUN mkdir -p /app/database /app/frontend/static/uploads

# Expose the port the app runs on
EXPOSE 5000

# Set environment variables
ENV FLASK_APP=backend/app.py
ENV FLASK_RUN_HOST=0.0.0.0
ENV PORT=5000

# Run with gunicorn for production (Render sets PORT automatically)
CMD gunicorn --bind 0.0.0.0:$PORT --chdir /app backend.app:app

