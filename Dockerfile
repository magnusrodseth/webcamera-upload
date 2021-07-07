FROM ubuntu:latest

# Install dependencies
RUN apt-get -yq update
RUN apt-get -yqq install ssh
RUN apt-get -yqq install python3.8-venv
RUN apt-get -yqq install python3-pip

# Add relevant files and grant execution rights
ADD upload.sh /upload.sh
ADD upload.py /upload.py
ADD requirements.txt /requirements.txt
RUN chmod +x /upload.sh

# Authorize SSH Host
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan 46.101.126.212 > /root/.ssh/known_hosts

# Upload file on container startup
CMD usr/bin/sh /upload.sh path_to_file_on_client_host path_to_file_on_destination_host
