FROM python:3.7-slim AS base

# Maintainer Information:
MAINTAINER Yutao Tang

RUN apt-get update && DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends \
    python3-dev python3-pip python3-setuptools libgtk2.0-dev git g++ wget make vim curl libgl1-mesa-glx \
    nginx supervisor

RUN pip3 install --upgrade setuptools pip

FROM BASE AS RUNTIME

# Copy the current directory contents into the container at /app
COPY requirements.txt ./

# Install Dependencies
RUN pip3 install -r ./requirements.txt

# Set the Working Directory to /app
WORKDIR /app

# Copy the current directory contents into the container at /app
COPY . ./


# Healthcheck
HEALTHCHECK CMD pidof python3 || exit 1

# Expose flask port 8080
EXPOSE 8080

# Run Python app
CMD ["python3", "app.py"]

