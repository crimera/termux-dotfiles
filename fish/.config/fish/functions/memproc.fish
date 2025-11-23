function memproc --description 'Show RSS for a process; defaults to tmux. Modes: server|all|sum'
    # args & defaults
    set -l proc $argv[1]
    if test -z "$proc"
        set proc tmux
    end
    set -l mode $argv[2]
    if test -z "$mode"
        set mode server
    end
    # find matching PIDs
    set -l pids (pgrep -x -- $proc 2>/dev/null)
    if test (count $pids) -eq 0
        printf "no '%s' process\n" $proc
        return 1
    end
    set -l idlist (string join , $pids)
    # detect server (PPID == 1), fall back to first match
    set -l server ''
    for pid in $pids
        set -l ppid (ps -p $pid -o ppid= | string trim)
        if test "$ppid" = "1"
            set server $pid
            break
        end
    end
    if test -z "$server"
        set server $pids[1]
    end
    # output according to mode
    switch $mode
        case server
            ps -p $server -o pid=,ppid=,rss=,comm= | awk '{printf "PID %s (PPID %s): %s KB (%.2f MB) - %s\n",$1,$2,$3,$3/1024,$4}'
        case all
            ps -p $idlist -o pid=,ppid=,rss=,comm= | awk '{printf "PID %s (PPID %s): %s KB (%.2f MB) - %s\n",$1,$2,$3,$3/1024,$4}'
        case sum
            ps -p $idlist -o rss= | awk '{sum+=$1} END{printf "%d KB (%.2f MB)\n", sum, sum/1024}'
        case '*'
            printf "unknown mode: %s\n" $mode
            return 2
    end
end
