#!/usr/bin/env bash

# Current time
now=$(date)

echo "> 📷 Running \"Webcamera upload\" script"
echo "> 🕓 Current date: $now"

# Print empty line
echo

create_venv_if_not_exists() {
    
    venv_dir="./venv"
    
    if [ -d $venv_dir ]; then
        echo "> ⏳ Directory $venv_dir already exists. Ensuring that all modules are installed..."
        
    else
        echo "> ⏳ Directory $venv_dir does not exist. Initializing virtual environment..."
        # Create Python virtual environment called 'venv'
        $(which python3) -m venv venv
        
    fi;
    
    sleep 1
    
    # Print empty line
    echo
    
    # Install modules
    $(which python3) -m pip install -r requirements.txt
    
    sleep 1
}

# Activates the relevant Python virtual environment
activate_venv() {
    # Set current working directory in order to find the proper Python file
    cd "$(dirname "$0")"
    
    create_venv_if_not_exists
    
    # Determine operating system
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        # Linux
        echo "> 💻 Operating system: Linux / GNU"
        source venv/bin/activate
        
        elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        echo "> 💻 Operating system: MacOS"
        source venv/bin/activate
        
        elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
        echo "> 💻 Operating system: Windows"
        venv\\Scripts\\activate.bat
        
        elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
        echo "> 💻 Operating system: Windows"
        venv\\Scripts\\activate.bat
        
    fi;
    
    sleep 1
    
    # Print empty line
    echo
    
    # Run Python script for uploading file using SFTP
    $(which python3) upload.py $1 $2
}

# When running the shell script, the user indirectly provides the Python script with local and destination path
activate_venv $1 $2