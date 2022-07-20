import subprocess
from json import dumps, loads
from sys import argv
from re import search
from termux import UI

MUSIC="storage/music"
ASMR="storage/shared/.nsfw"
VIDEOS="storage/movies"
CLIPS="storage/movies/Clips"
DOWNLOADS="storage/downloads/navi/"

class Site:
    def __init__(self, re):
        self.re = re

youtube = Site("^(https?\:\/\/)?((www\.)?youtube\.com|youtu\.be)\/.+$")
zippyshare = Site("/http.*zippyshare.*\.html/gm")

def run ():
  

def dlmusic (url):
  process = subprocess.Popen(
    ['yt-dlp', '-f bestaudio', '--extract-audio', '--embed-thumbnail', '--embed-metadata', '-o ASME/yt/%(channel)s/%(upload_date)s-%(title)s-%(id)s.%(ext)s', url],
    stdout=subprocess.PIPE,
    universal_newlines=True
    )
  while True:
    output = process.stdout.readline()
    print(output.strip())
    # Do something else
    return_code = process.poll()
    if return_code is not None:
        print('RETURN CODE', return_code)
        # Process has finished, read rest of the output 
        for output in process.stdout.readlines():
            print(output.strip())
        break

def urlparser (url):
    def re(re):
        return search(re, url)

    if re(youtube.re):
        menu = UI.sheet(opts=["Music", "Asmr", "Clip", "Video"], title="name")
        output = loads(dumps(menu))[1]["index"]
        
        match output:
          case 0:
            dlmusic(url)
            

def main ():
    url = argv[1] 
    
    urlparser(url)

if __name__ == "__main__":
    main()