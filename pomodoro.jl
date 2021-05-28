#------------------------------------------------------------------------------
# pomodoro - Pomodoro timer
# Copyright (C) 2021  Domagoj Marsic
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Contact:
# https://github.com/dmarsic
# <dmars+github@protonmail.com>
#------------------------------------------------------------------------------

using Alert
using Printf

# Focused time in seconds
const WORK_TIME = 20 * 60

# Short rest time in seconds
const REST_TIME = 5 * 60

# Long rest time in seconds at the end of cycle
const LONG_REST_TIME = 30 * 60

# How many iterations of focused time / short rest time before long rest time
const LONG_REST_COUNT = 4


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

pomodoro(WORK_TIME, REST_TIME, LONG_REST_TIME, LONG_REST_COUNT)

