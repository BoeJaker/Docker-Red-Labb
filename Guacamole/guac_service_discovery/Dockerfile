# Use an official Python runtime as a parent image
FROM python:3.8-slim

RUN apt-get update && apt-get install -y \
    wget \
    gnupg \
    unzip \
    && wget -q -O - https://dl-ssl.google.com/linux/linux_signing_key.pub | apt-key add - \
    && echo "deb [arch=amd64] http://dl.google.com/linux/chrome/deb/ stable main" >> /etc/apt/sources.list.d/google-chrome.list \
    && apt-get update && apt-get install -y \
    google-chrome-stable \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Download and install ChromeDriver
RUN CHROMEDRIVER_VERSION=$(wget -q -O - https://chromedriver.storage.googleapis.com/LATEST_RELEASE) \

    && wget https://edgedl.me.gvt1.com/edgedl/chrome/chrome-for-testing/120.0.6099.109/linux64/chromedriver-linux64.zip \
    && unzip chromedriver-linux64.zip  \
    && cd ./chromedriver-linux64  \
    && mv chromedriver /usr/local/bin/ \
    && cd .. \
    && rm chromedriver-linux64.zip 

# Set the PATH to include ChromeDriver
ENV PATH="/usr/local/bin:${PATH}"

# Copy the current directory contents into the container at /app
# COPY ./app/requirements.txt /app/requirements.txt

# Install any needed packages specified in requirements.txt
RUN pip install --no-cache-dir psycopg2-binary docker dotenv
# RUN chmod +x app/gsheetoauth.py

RUN openssl req -x509 -newkey rsa:4096 -keyout /key.pem -out /cert.pem -days 365 -passout pass:password -subj "/CN=example.com/O=My Organization/C=US"

# Run script.py when the container launches
CMD ["sh", "-c", "python /gsd.py"]
