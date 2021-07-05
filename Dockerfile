FROM ubuntu:latest

# Install cron
RUN apt-get -yq update
RUN apt-get -yqq install cron
RUN apt-get -yqq install ssh
RUN apt-get -yqq install python3.8-venv
RUN apt-get -yqq install python3-pip

# Add crontab file in the cron directory
ADD crontab /etc/cron.d/simple-cron

# Add relevant files and grant execution rights
ADD upload.sh /upload.sh
ADD upload.py /upload.py
ADD requirements.txt /requirements.txt

# TODO: Remove this when done
ADD test.txt /test.txt

RUN chmod +x /upload.sh

# Authorize SSH Host
RUN mkdir -p /root/.ssh && \
    chmod 0700 /root/.ssh && \
    ssh-keyscan 46.101.126.212 > /root/.ssh/known_hosts

# Give execution rights on the cron job
RUN chmod 0644 /etc/cron.d/simple-cron

# Create the log file to be able to run tail
RUN touch /var/log/cron.log

# Run the command on container startup
CMD cron && tail -f /var/log/cron.log