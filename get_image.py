import requests
import json
from datetime import date

bing_base = "http://www.bing.com"
bing_wallpaper = "/HPImageArchive.aspx?format=js&idx=0&n=1&mkt=en-IN"

resp1 = requests.get(bing_base + bing_wallpaper)

if resp1.status_code == 200:
    json_response = json.loads(resp1.content)
    wallpaper_path = json_response['images'][0]['url']

    filename = f"images/bg_{date.today()}.jpeg"
    wallpaper_uri = bing_base + wallpaper_path

    # open actual wallpaper uri, and write to an image
    resp2 = requests.get(wallpaper_uri)

    if resp2.status_code == 200:
        with open(filename, 'wb') as f:
            f.write(resp2.content)
    else:
        print(f"ERROR: non-200 response from Bing server for '{wallpaper_uri}'")
else: 
    print(f"ERROR: non-200 response from Bing server for '{bing_base + bing_wallpaper}'")