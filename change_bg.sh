#!/bin/bash
set -e
today=$(date -I)

# mkdir images
if [ ! -d "images" ]; then
    mkdir images
fi

if [ ! -f "images/bg_$today.jpeg" ]; then

    if [ ! -d "env" ]; then
        python3 -m venv env
    fi

    source env/bin/activate
    pip install requests
    python3 get_image.py
    deactivate

    current_dir=($PWD)
    file_uri="file://$current_dir/images/bg_$today.jpeg"

    export GIO_EXTRA_MODULES=/usr/lib/x86_64-linux-gnu/gio/modules/
    gsettings set org.gnome.desktop.background picture-uri $file_uri 2> /dev/null
fi