# Webcamera upload 📷

## What is it ❓

This repository has a single Python script. `upload.py` allows you to securely transmit a file from your local computer to a destination host using the [SFTP protocol](https://www.digitalocean.com/community/tutorials/how-to-use-sftp-to-securely-transfer-files-with-a-remote-server).

The purpose of the repository is to use the `upload.py` script to transmit webcamera images from a client computer to a remote server.

## Developer Information 🙋🏼‍♂️

Developed by Magnus Rødseth and Julian Grande, summer 2021.

## Setting environment variables ❗️

A very important prerequisite in order for `upload.py` to work is setting correct environment variables before running the script. Start by creating a file called `.env` in the repository directory (`webcamera-upload`).

**`webcamera-upload/.env`**

```env
HOSTNAME=destination_ip_address
USERNAME=destination_username
PASSWORD=destination_password
```

As you can see from the sample file above, this script requires you to know the listed information about your destination host.

## Freezing requirements ❄️

**`Terminal`**

```shell
python3 -m pip freeze > requirements.txt
```

## Virtual environment 🌳

**`Terminal`**

```shell
# Create virtual environment
python3 -m venv venv

# Activate using Windows:
venv\Scripts\activate.bat

# OR

# Activate using Mac or Unix:
source venv/bin/activate

# Install requirements
python3 -m pip install -r requirements.txt
```
