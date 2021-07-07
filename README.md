# Webcamera upload 📷

## Description 📄

This repository allows you to securely transmit a file from your local computer to a destination host using the [SFTP protocol](https://www.digitalocean.com/community/tutorials/how-to-use-sftp-to-securely-transfer-files-with-a-remote-server).

The user preferably sets up a cronjob to run `docker restart webcam-upload`. The Docker container then runs the Bash script `upload.sh` by giving it parameters (more on that below). The Bash script sets up a Python virtual environment, and executes the Python script `upload.py` with parameters provided to the Bash script.

The purpose of this particular repository is to transmit webcamera images from a client computer to a remote server, but the repository can transmit any file.

## Developer Information 🙋🏼‍♂️

Developed by Magnus Rødseth and Julian Grande, summer 2021.

## Setting environment variables ❗️

A very important prerequisite in order for the workflow to function correctly is setting correct environment variables before running the script. Start by creating a file called `.env` in the repository directory (`webcamera-upload`).

**`webcamera-upload/.env`**

```env
HOSTNAME=destination_ip_adreess
USERNAME=destination_username
PRIVATE_KEY_PATH=your_private_key_path
PASSWORD=your_password
```

As you can see from the sample file above, this script requires you to know the listed information about your destination host.

## Running the application for the first time ✅

Clone the repository.

Ensure you have Docker installed and running successfully.

Navigate to the repository directory (`webcamera-upload`).

Run the following command to spin up the Docker multi-container for the first time: `docker-compose up`.

Now, set up a cronjob with desired interval and an instruction to restart the Docker multi-container after this interval. An example can be seen below:

```shell
# Uploads webcam image at minute 2, 17, 32, and 47 past every hour from 8 through 16
02,17,32,47 8-16 * * * docker restart sobekkseter-upload
```

If you want to run this workflow without maintaining it, you can set up cron to start running when your computer boots up.

## Freezing requirements ❄️

When developing, you may need to install Python modules. After pushing to GitHub, remember to **freeze** the requirements _inside_ the virtual environment.

**`Terminal`**

```shell
python3 -m pip freeze > requirements.txt
```

## Virtual environment 🌳

Note that all of this is later handled by the Bash script `upload.sh`.

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

## Public / Private Key Generation 🔐

Start by generating an SSH key-pair on the client computer.

```shell
# Generate public-private key pair
ssh-keygen

# Give your key pair a descriptive name

# On MacOS / Linux
cat ~/.ssh/your_key_pair.pub

# OR

# On Windows PowerShell
Get-Content C:\.ssh\your_key_pair.pub
```

In order to SFTP files from a client IP address to a destination IP address, the destination IP address must have the client public key.
Send this public key to the destination IP address.

Have the destination IP address add the key in `~/.ssh/known_hosts` with the following format:

```shell
client_ip_address ssh-rsa client_public_key
```

Then have the destination IP address add the key in `~/.ssh/authorized_keys`. Simply copy the client public key at the bottom of the `authorized_keys` file.

On the client IP address, open your terminal and type `ssh-keyscan destination_ip_address`. Add content of `ssh-rsa` to client IP address' `~/.ssh/known_hosts` on the following format:

```shell
destination_ip_address ssh-rsa copy_pasted_value_from_ssh-keyscan
```

The key-pairs should now be set up properly for the shell script to successfully upload files!

## Setting up and running the cron job 🔁

If you do not know how `cron` works, you can read more about it using [this link](https://en.wikipedia.org/wiki/Cron).

**`Terminal`**

```shell
# Open the cron table without root permissions
crontab -e

# OR, if needed

# Open the cron table with root permissions
sudo crontab -e

# Remove everything in crontab
crontab -r

# Uploads webcam image at minute 2, 17, 32, and 47 past every hour from 8 through 16
02,17,32,47 8-16 * * * docker restart sobekkseter-upload
```
