# Stage 1: Build stage
FROM python:3.8 AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy the requirements file
COPY requirements.txt .

# Install the project dependencies
RUN pip install --user --no-cache-dir -r requirements.txt

# Stage 2: Production stage
FROM python:3.8-slim

# Set the working directory inside the container
WORKDIR /app

# Copy the installed dependencies from the builder stage
COPY --from=builder /root/.local /root/.local

# Copy the application code into the container
COPY . .

# Expose the port the Flask application will be listening on
EXPOSE 5000

# Set environment variables, if necessary
# ENV MY_ENV_VAR=value

# Include the local bin directory in the PATH environment variable
ENV PATH=/root/.local/bin:$PATH

# Run the Flask application
CMD ["python", "app.py"]
