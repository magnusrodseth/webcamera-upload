# Webcamera upload 📷

## Description 📄

This repository allows you to securely transmit a file from your local computer to a destination host using the [SFTP protocol](https://www.digitalocean.com/community/tutorials/how-to-use-sftp-to-securely-transfer-files-with-a-remote-server).

A user interacts with the Bash script `upload.sh` by giving it parameters (more on that below). The Bash script then sets up a Python virtual environment, and executes the Python script `upload.py` with parameters provided to the Bash script.

The purpose of this particular repository is to transmit webcamera images from a client computer to a remote server, but the repository can transmit any file.

## Developer Information 🙋🏼‍♂️

Developed by Magnus Rødseth and Julian Grande, summer 2021.

## Setting environment variables ❗️

A very important prerequisite in order for `upload.py` to work is setting correct environment variables before running the script. Start by creating a file called `.env` in the repository directory (`webcamera-upload`).

**`webcamera-upload/.env`**

```env
HOSTNAME=destination_ip_address
USERNAME=destination_username
PASSWORD=private_key_password
PRIVATE_KEY_PATH=~/.ssh/rsa_key_name
```

As you can see from the sample file above, this script requires you to know the listed information about your destination host.

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

On the client IP address, open your terminal add type `ssh-keyscan destination_ip_address`. Add content of `ssh-rsa` to client IP address' `~/.ssh/known_hosts` on the following format:

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

# Add cron job to cron table
*/15 * * * * bash upload.sh local_file_path destination_directory >> ~/cron-logs/cron.log 2>&1
```
