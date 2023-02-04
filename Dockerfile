# Use an official Python runtime as the base image
FROM python:3.6
# RUN mkdir djangoProject
# Set the working directory to /app
# WORKDIR djangoProject
RUN apt-get update -y
RUN apt-get install python3-pip -y
RUN pip install virtualenv

# Copy the rest of the project files to the container
COPY MyPoject .
# Install the required packages
RUN virtualenv venv
RUN . venv/bin/activate
RUN pip install --no-cache-dir -r requirements.txt

RUN python manage.py makemigrations
RUN python manage.py migrate

# Expose port 8000 for the Gunicorn server
EXPOSE 8000

# Run the command to start Gunicorn
CMD gunicorn MyPoject.wsgi:application --bind 0.0.0.0:8000

