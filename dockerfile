# Use Python 3.9 base image
FROM python:3.9-alpine

# Set the working directory in the container
WORKDIR /app

# Copy only the requirements file initially to leverage Docker layer caching
COPY requirement.txt .

# Install dependencies
RUN apk update && \
    apk add --no-cache curl && \
    pip install --no-cache-dir -r requirement.txt && \
    pip install --upgrade pip
    


# Copy the rest of the application files into the container
COPY . .

# Ensure files are owned by non-root user for security
RUN chown -R nobody:nogroup /app

# Install hadolint
RUN curl -sSL -o /usr/bin/hadolint "https://github.com/hadolint/hadolint/releases/download/v2.7.0/hadolint-Linux-x86_64" \
    && chmod 755 /usr/bin/hadolint

# Lint the Dockerfile
RUN hadolint dockerfile || true

# Command to run the FastAPI app
USER nobody:nogroup
CMD ["python", "app.py"]
