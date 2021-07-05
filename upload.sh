#!/usr/bin/env bash

print() {
    # Print content
    echo $1
    
    # Print new line
    echo
}

# Current time
now=$(date)

print "> Running \"Webcamera upload\" script"
print "> Current date: $now"

create_venv_if_not_exists() {
    
    venv_dir="venv"
    
    if [ -d $venv_dir ]; then
        print "> Directory $venv_dir already exists. Ensuring that all modules are installed..."
        
    else
        print "> Directory $venv_dir does not exist. Initializing virtual environment..."
        # Create Python virtual environment called 'venv'
        $(which python3) -m venv venv
        
    fi;
    
    sleep 1
    
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
        print "> Operating system: Linux / GNU"
        source venv/bin/activate
        
        elif [[ "$OSTYPE" == "darwin"* ]]; then
        # Mac OSX
        print "> Operating system: MacOS"
        source venv/bin/activate
        
        elif [[ "$OSTYPE" == "msys" ]]; then
        # Lightweight shell and GNU utilities compiled for Windows (part of MinGW)
        print "> Operating system: Windows"
        venv\\Scripts\\activate.bat
        
        elif [[ "$OSTYPE" == "win32" ]]; then
        # I'm not sure this can happen.
        print "> Operating system: Windows"
        venv\\Scripts\\activate.bat
        
    fi;
    
    sleep 1
    
    # Run Python script for uploading file using SFTP
    $(which python3) upload.py $1 $2
}

# When running the shell script, the user indirectly provides the Python script with local and destination path
activate_venv $1 $2