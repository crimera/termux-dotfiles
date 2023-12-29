#!/data/data/com.termux/files/usr/bin/python

from ytmusicapi import YTMusic
import os.path
from urllib.parse import urlparse
import os
import requests
import json
import sys

# Get spotify track info
url = sys.argv[1]

trackId = os.path.split(urlparse(url).path)[-1]

params = {
    'reason': 'transport',
    'productType': 'web-player',
}

getToken = requests.get('https://open.spotify.com/get_access_token', params=params).json()
token = getToken["accessToken"]

headers = {
    'Authorization': f'Bearer {token}',
}

params = {
    'operationName': 'getTrack',
    'variables': '{"uri":"spotify:track:%s"}' % trackId,
    'extensions': '{"persistedQuery":{"version":1,"sha256Hash":"e101aead6d78faa11d75bec5e36385a07b2f1c4a0420932d374d89ee17c70dd6"}}',
}

getTrack = requests.get('https://api-partner.spotify.com/pathfinder/v1/query', params=params, headers=headers).json()

name = getTrack["data"]["trackUnion"]["name"]
artist = getTrack["data"]["trackUnion"]["firstArtist"]["items"][0]["profile"]["name"]

# Search ytnmusic

ytmusic = YTMusic()
query = f"{name} {artist}"

search_results = ytmusic.search(query, "songs")

videoId = search_results[0]["videoId"]

print("Downloading "+search_results[0]["title"])

music = f'{os.getenv("HOME")}/storage/music'

# Download
os.system(f'yt-dlp https://music.youtube.com/watch?v={videoId} -x --embed-thumbnail --embed-metadata -o "{music}/%(title)s.%(ext)s" --postprocessor-args "ffmpeg:-filter:v crop=in_h"')