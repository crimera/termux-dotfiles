#!/bin/bash

if tmux list-panes -F "#{pane_start_command}" | grep -q "opencode -c"; then
    pane_id=$(tmux list-panes -F "#{pane_id} #{pane_start_command}" | grep "opencode -c" | awk '{print $1}')
    tmux kill-pane -t "$pane_id"
else
    tmux split-window -h -l 35% -c "$(tmux display-message -p '#{pane_current_path}')" "opencode -c"
fi
