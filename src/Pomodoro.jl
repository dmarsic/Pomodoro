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

module Pomodoro
using Alert
using Printf

    struct Mode
        name::String
        length_s::Integer
    end

    mutable struct Cycle
        modes::Dict
        mode::Mode
        next::Mode
        short_rest_count::Integer
        total_cycles::Integer
        work_states_in_cycle::Integer
    end

    function pomodoro(opts)
        work = Mode("work", opts.work_time_s)
        short_rest = Mode("short rest", opts.rest_time_s)
        long_rest = Mode("long rest", opts.long_rest_time_s)

        cycle = Cycle(
            Dict("work" => work, "short_rest" => short_rest, "long_rest" => long_rest),
            work, short_rest, 0, 0, 0)
        time_passed_s = 0

        while true
            @printf("\r%10s | cycle: %d | work: %d | minutes: %d of %d",
                cycle.mode.name, cycle.total_cycles, cycle.work_states_in_cycle,
                sec_to_min(time_passed_s), sec_to_min(cycle.mode.length_s))
            time_passed_s += 1
            sleep(1)

            if time_passed_s >= cycle.mode.length_s
                if cycle.mode == long_rest
                    cycle.total_cycles += 1
                    cycle.work_states_in_cycle = 0
                end
                cycle = change_state(cycle)
                if cycle.mode == work
                    cycle.work_states_in_cycle += 1
                end
                if opts.notify
                    notify(cycle)
                end
                time_passed_s = 0
            end
        end
    end

    function change_state(cycle::Cycle)
        if cycle.mode.name == "work"
            if cycle.short_rest_count < 3
                cycle.mode = cycle.modes["short_rest"]
                cycle.next = cycle.modes["work"]
                cycle.short_rest_count += 1
            else
                cycle.mode = cycle.modes["long_rest"]
                cycle.next = cycle.modes["work"]
                cycle.short_rest_count = 0
            end
        else
            cycle.mode = cycle.modes["work"]
            cycle.next = cycle.modes["short_rest"]
        end
        return cycle
    end

    function notify(cycle::Cycle)
        duration_min = cycle.mode.length_s / 60
        alert(@sprintf("%s for the next %d minutes", cycle.mode.name, duration_min))
    end

    function sec_to_min(s::Integer)
        return s / 60
    end
end