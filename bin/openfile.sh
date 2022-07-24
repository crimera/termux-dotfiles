termux-toast -s "download finished"

termux-notification -c "$3 Download done" \
  --icon file_download \
  --action "termux-open $3"