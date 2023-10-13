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
#------------------------------------------------------------------------------

include("src/Pomodoro.jl")

# Focused time in seconds
const WORK_TIME = 20 * 60

# Short rest time in seconds
const REST_TIME = 5 * 60

# Long rest time in seconds at the end of cycle
const LONG_REST_TIME = 30 * 60

# How many iterations of focused time / short rest time before long rest time
const LONG_REST_COUNT = 4

# Show notification bubble on state change
const NOTIFY = true

# Wait for confirmation before changing state
const PAUSE_CONFIRM = true

struct Options
    work_time_s::Integer
    rest_time_s::Integer
    long_rest_time_s::Integer
    long_rest_count::Integer
    notify::Bool
    pause_confirm_state_change::Bool
end

Pomodoro.pomodoro(Options(
    WORK_TIME, REST_TIME, LONG_REST_TIME, LONG_REST_COUNT, NOTIFY, PAUSE_CONFIRM
))