# Use an official Python runtime as a parent image
FROM python:3.8-slim

RUN apt-get update && apt-get install -y
RUN pip install --upgrade pip
RUN pip install --upgrade setuptools
# Install any needed packages specified in requirements.txt
RUN pip install psycopg2-binary docker python-dotenv
# RUN chmod +x app/gsheetoauth.py

COPY gsd.py /gsd.py
COPY .env /.env

# Run script.py when the container launches
CMD ["sh", "-c", "python /gsd.py"]
