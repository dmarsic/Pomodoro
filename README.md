# Introduction

Pomodoro timer is a time management application. It runs indefinitely
in cycles, allowing periods of focused time with short rests. A long
rest comes after a fixed number of focused intervals.

A desktop notification informs about the start of next phase: work,
short rest, or a long rest

https://en.wikipedia.org/wiki/Pomodoro_Technique

# Prerequisites

`pomodoro.jl` is a [Julia](https://julialang.org/) script.

Dependencies:

* [Alert](https://github.com/haberdashPI/Alert.jl)

See [documentation](https://docs.julialang.org/en/v1/stdlib/Pkg/) on how
to install packages.

# Run

Phase lengths are declared as constants at the beginning of the script.

Run as a Julia script:

```bash
julia pomodoro.jl
```

# Licence

GNU GPL v3. See LICENSE.

# Author

Domagoj Marsic, 2021

Contact: dmars+github@protonmail.com
