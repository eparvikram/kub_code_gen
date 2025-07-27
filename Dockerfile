# Use a lightweight official Python image as the base
FROM python:3.9-slim-buster

# Set the working directory in the container
WORKDIR /app

# Copy the requirements file into the container
COPY requirements.txt .

# Install Python dependencies
# Use --no-cache-dir to avoid storing cache, reducing image size
# Use --upgrade pip to ensure pip is up-to-date
RUN pip install --no-cache-dir --upgrade pip && \
    pip install --no-cache-dir -r requirements.txt

# Copy the application code into the container
# Assuming your FastAPI application code is in an 'app' directory
COPY ./app /app/app

# Expose the port that your FastAPI application will listen on
# This should match the containerPort in your Kubernetes deployment.yaml
EXPOSE 8000

# Command to run the FastAPI application using Uvicorn
# The 'app.main:app' assumes your main FastAPI instance is named 'app'
# in a file named 'main.py' inside the 'app' directory.
# --host 0.0.0.0 makes the app accessible from outside the container.
CMD ["uvicorn", "app.main:app", "--host", "0.0.0.0", "--port", "8000"]

# Optional: Add metadata for better image management
LABEL maintainer="your-email@example.com"
LABEL description="Docker image for FastAPI application"
