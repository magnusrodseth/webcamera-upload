# Import modules
import pysftp
import sys
import os
from dotenv import load_dotenv


# Load environment variables
load_dotenv()


def upload(argv):
    """
    This method uses SFTP to upload a given file to a given host.
    The hostname, destination username and destination password are set
    in a .env file in the same directory as this upload.py file.

    :param argv: Variable length arguments. The first argument corresponds to the local file path. The second argument corresponds to the destination directory on the destination host.

    :return: a boolean value determining whether the operation was successful or not.
    """

    # argv should only process 2 arguments
    if len(argv) != 2:
        print("> Invalid input. Please use the following format:")
        print(f'$ python3 upload.py local_file_path destination_directory')
        return False

    local_file_path = argv[0]
    destination_directory = argv[1]

    print(f'> Local file path: {local_file_path}')
    print(f'> Destination directory: {destination_directory}')

    print(f'> Establishing SFTP connection with destination host...')

    with pysftp.Connection(
            host=os.environ.get('HOSTNAME'),
            username=os.environ.get('USERNAME'),
            private_key_pass=os.environ.get('PASSWORD'),
            private_key=os.environ.get('PRIVATE_KEY_PATH')
    ) as sftp:
        with sftp.cd(destination_directory):
            print(f'> Uploading file to destination...')
            sftp.put(local_file_path)  # Upload file

            return True


if __name__ == '__main__':
    # Syntax: python3 upload.py local_file_path destination_directory
    succeeded = upload(sys.argv[1:])

    print(
        "> Successfully uploaded file!"
        if succeeded
        else "> An error occurred when trying to upload the file!"
    )
