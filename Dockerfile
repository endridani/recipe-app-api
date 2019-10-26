# 'Dockerfile' is the standard convention that Docker uses to identify the Docker file in our project
# Docker file contains a list of instructions from Docker to build the Docker Image
# You describe the dependencies you need for your project

# Select the image on which you want to build your Docker file and base your project from
# You can add instructions on top of the ones already contained in the selected Docker image
# Pretty much you are building an image on top of another image

# The image from which this project will be based on
# Optional name of the maintainer
FROM python:3.7-alpine
MAINTAINER Endri Dani
# Set environment variable. This variable runs Python in unbuffered mode which is recommended for Docker
ENV PYTHONUNBUFFERED 1

# Store our dependencies on requirements.txt
# Copy this file from our local directory to our Docker image
COPY ./requirements.txt /requirements.txt
# Run the command to install requirements in Docker image
RUN pip install -r /requirements.txt

# Create a directory in the Docker image which will be used to store our source code
RUN mkdir /app
# Switch to this folder as a default directory. Any application we run using this Docker container will run starting from this location
WORKDIR /app
# Copy from our local machine to the Docker Image all the files inside /app
COPY ./app /app

# Create a user that is going to run our application using Docker.
# -D : Create a user that will be used to run applications only
# username is user
# This is done for security purposes. Otherwise Docker will use our root account when running which is not recommended
RUN adduser -D user
# Switch to that user
USER user


# On your cmd run "docker build ." to build our Docker image