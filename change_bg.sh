#!/bin/bash

chmod +x -- "$0"
today=$(date -I)

# mkdir images
if [ ! -d "images" ]; then
    mkdir images
fi

if [ ! -f "images/bg_$today.jpeg" ]; then

    python3 -m venv env
    source env/bin/activate

    pip3 install --upgrade pip
    pip3 install requests

    python3 get_image.py

    deactivate
    rm -r env

    export GIO_EXTRA_MODULES=/usr/lib/x86_64-linux-gnu/gio/modules/
    current_dir=($PWD)
    file_uri="file://$current_dir/images/bg_$today.jpeg"

    gsettings set org.gnome.desktop.background picture-uri $file_uri
fi