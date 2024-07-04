#!/bin/bash

# Update package list and install dependencies
apt-get update
apt-get install -y openjdk-11-jre wget

# Download and run the backend application
wget https://your-docker-registry-url/backend.jar -O /opt/backend.jar
java -jar /opt/backend.jar &
