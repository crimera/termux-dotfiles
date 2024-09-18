# /bin/python

from urllib.parse import urlparse
from typing import Tuple, Callable, List
import json
import sys
import os
import subprocess

HOME = os.getenv("HOME")
STORAGE = f"{HOME}/storage"
MUSIC = f"{STORAGE}/music"
ASMR = f"{STORAGE}/shared/.nsfw"
VIDEOS = f"{STORAGE}/movies"
CLIPS = "f{STORAGE}/movies/Clips"
DOWNLOADS = "f{STORAGE}/downloads"
DEBUG = True

YT_DLP = [
    "yt-dlp",
    "--no-mtime",
    "-N",
    "8",
    "--embed-thumbnail",
    "--embed-metadata",
]


def output(output):
    return ["-o", output]


def run(*cmd: str):
    out = subprocess.run(
        cmd, universal_newlines=True, stdout=subprocess.PIPE
    )
    
    if (DEBUG):
        print(out)
        
    return out


music = (
    "Music",
    lambda url: run(
            url,
            *YT_DLP,
            "--postprocessor-args",
            "ffmpeg:-filter:v crop=in_h",
            output(f"{MUSIC}/%(title)s.%(ext)s"),
    ),
)

asmr = (
    "ASMR",
    lambda url: run(
            url,
            *YT_DLP,
            output(f"{ASMR}/yt/%(channel)s/%(uploader_id)s %(upload_date)s-%(title).150B-%(id)s.%(ext)s"),
    ),
)


# should only take option names and return the chosen index
def dialog(options: List[Tuple[str, Callable]], url: str):
    option_names: str = ",".join([x[0] for x in options])
    result = run("termux-dialog", "sheet", "-v", option_names).stdout
    index = json.load(result)["index"]
    options[index][1](url)

def main():
    url = sys.argv[1]
    print(url)

    parsed_uri = urlparse(url)
    host = parsed_uri.hostname

    match host:
        case "www.youtube.com" | "m.youtube.com":
            run(YT_DLP, url, "-x")
        case _:
            dialog(url)

if __name__ == "__main__":
    dialog([music, asmr])
