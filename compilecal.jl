using Pkg
Pkg.activate(".")
Pkg.instantiate()
using CourseCalendar

calfile = joinpath(pwd(), "F23", "calendar.toml")
topics = joinpath(pwd(), "F23", "topics.txt")
sched = courseSchedule(calfile, topics)

md = mdcalendar(sched)

hdg = """---
title: "Schedule"
layout: page
nav_order: 1
has_children: true
---

# Greek 213: daily schedule

"""

open(joinpath(pwd(), "docs", "schedule", "index.md"), "w") do io
    write(io, hdg * md)
end