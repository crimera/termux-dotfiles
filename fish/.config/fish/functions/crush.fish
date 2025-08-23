function crush
    if not pgrep -f "[c]opilot-api" >/dev/null 2>&1
        setsid nohup copilot-api start >/dev/null 2>&1 </dev/null &
        disown >/dev/null 2>&1
        for i in (seq 1 20)
            if pgrep -f "[c]opilot-api" >/dev/null 2>&1
                break
            end
            sleep 0.1
        end
    end
    command crush $argv
end
