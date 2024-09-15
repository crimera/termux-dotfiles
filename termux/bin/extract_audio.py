#!/data/data/com.termux/files/usr/bin/python

import base64
import subprocess
from pathlib import Path
import sys
from mutagen.oggopus import OggOpus
from mutagen.flac import Picture
from mutagen.mp4 import MP4, MP4Cover


def get_streams(filePath: str) -> list:
    raw_out = subprocess.run(
        ["ffprobe", filePath, "-show_streams", "-v", "quiet"],
        check=True,
        capture_output=True,
        universal_newlines=True,
    )

    streams: list = []

    for line in raw_out.stdout.splitlines():
        if line == "[STREAM]":
            streams.append({})
            continue

        if line == "[/STREAM]":
            continue

        key_val = line.split("=")

        streams[-1][key_val[0]] = key_val[1]

    return streams


def get_audio_codec(filename) -> str:
    streams = get_streams(filename)

    for stream in streams:
        if stream["codec_type"] == "audio":
            return stream["codec_name"]

    raise Exception("Does not contain an audio stream")


def get_duration(filename: str) -> float:
    return float(
        subprocess.run(
            [
                "ffprobe",
                "-loglevel",
                "error",
                "-of",
                "csv=p=0",
                "-show_entries",
                "format=duration",
                filename,
            ],
            check=True,
            stdout=subprocess.PIPE,
        ).stdout
    )


def get_extension(filename: str) -> str:
    return filename.split(".")[-1]


def embed_to_opus(audiofile, thumbnailfile):
    file_ = OggOpus(audiofile)
    with open(thumbnailfile, "rb") as f:
        data = f.read()

    thumbnail = Picture()
    thumbnail.data = data
    thumbnail.type = 3
    thumbnail.desc = "Thumbnail"
    thumbnail.mime = "image/jpeg"
    thumbnail_data = thumbnail.write()
    encoded_data = base64.b64encode(thumbnail_data)
    vcomment_value = encoded_data.decode("ascii")

    file_["metadata_block_picture"] = [vcomment_value]
    file_.save()


def embed_to_m4a(audiofilename: str, thumbfilename: str):
    with open(thumbfilename, "rb") as f:
        data = f.read()

    file = MP4(audiofilename)
    if file.tags is not None:
        file.tags["covr"] = [MP4Cover(data=data, imageformat=MP4Cover.FORMAT_JPEG)]
        file.save()
    else:
        print("Failed to embed")


def has_attached_pic(filename: str) -> bool:
    out: bool = False
    for stream in get_streams(filename):
        if stream["DISPOSITION:attached_pic"] == "1":
            out = True
            break

    return out


def has_opus_stream(filename: str) -> bool:
    out: bool = False
    for stream in get_streams(filename):
        if stream["DISPOSITION:codec_name"] == "opus":
            out = True
            break

    return out


def get_basename(filename: str) -> str:
    return Path(filename).stem


def parse_codec(unparsed_codec: str) -> str:
    match unparsed_codec:
        case "opus":
            return "opus"
        case "aac":
            return "m4a"
        case _:
            raise Exception("Codec is not supported")


def extract_audio(videofile):
    codec = get_audio_codec(videofile)
    extension = parse_codec(codec)

    # get audio
    audiofilename = f"{get_basename(videofile)}.{extension}"
    subprocess.run(
        [
            "ffmpeg",
            "-i",
            videofile,
            "-map",
            "0",
            "-map",
            "-0:v",
            "-acodec",
            "copy",
            f"{audiofilename}",
        ]
    )

    # get thumbnail
    thumbfilename = f"{get_basename(videofile)}.jpg"
    if has_attached_pic(videofile):
        subprocess.run(
            [
                "ffmpeg",
                "-i",
                videofile,
                "-map",
                "0:v",
                "-map",
                "-0:V",
                "-vcodec",
                "mjpeg",
                f"{thumbfilename}",
            ]
        )
    else:
        midpoint = get_duration(videofile) * 0.5

        subprocess.run(
            [
                "ffmpeg",
                "-ss",
                str(midpoint),
                "-i",
                videofile,
                "-vframes",
                "1",
                "-vcodec",
                "mjpeg",
                f"{thumbfilename}",
            ]
        )

    print("embedding...")
    match extension:
        case "opus":
            embed_to_opus(audiofilename, thumbfilename)
        case "m4a":
            embed_to_m4a(audiofilename, thumbfilename)

    # delete thumbnail after embedding
    Path(thumbfilename).unlink()


def show_usage():
    print("""
USAGE:
Convert video to opus and automatically embed thumbnail
    main.py [videofile]
Embed thumbnail to an opus file *imagefile should be on mjpeg format*
    main.py [audiofile] [imagefile]
        """)


def main():
    args = len(sys.argv)

    if args == 1:
        show_usage()
        return

    filename = sys.argv[1]

    if args == 2:
        extract_audio(filename)
    elif args == 3:
        embed_to_opus(filename, sys.argv[2])
    else:
        show_usage()


if __name__ == "__main__":
    main()
