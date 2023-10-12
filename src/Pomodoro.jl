module Pomodoro
using Alert
using Printf

    function pomodoro(work_time, rest_time, long_rest_time, long_rest_count)
        mode = "work"
        cycle_count = 1
        rest_count = 0
        while true
            @printf("\r[%s] cycle: %d, short rests: %d", mode, cycle_count, rest_count)
            if mode == "work"
                work_min = work_time / 60
                alert(@sprintf("Work for the next %d minutes", work_min))
                sleep(work_time)
                mode = "rest"
            elseif mode == "rest" && rest_count < long_rest_count
                rest_min = rest_time / 60
                alert(@sprintf("Take rest for %d minutes", rest_min))
                rest_count += 1
                sleep(rest_time)
                mode = "work"
            else
                long_rest_min = long_rest_time / 60
                alert(@sprintf("Long rest time for %d minutes", long_rest_min))
                rest_count = 0
                cycle_count += 1
                sleep(long_rest_time)
                mode = "work"
            end
        end
    end

end # module
