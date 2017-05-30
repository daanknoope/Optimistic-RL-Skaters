extensions [table]
turtles-own [ dict ]
globals [nr-of-actions]


to setup
  clear-all
  reset-ticks


  set unreasonably-high-number 1000
  set nr-of-actions 360 / k

  create-turtles nr-of-skaters [
    setxy random-xcor random-ycor
    set size 3
    set dict table:make

    let i 0
    repeat nr-of-actions [
      table:put dict (k * i) list unreasonably-high-number 1
      set i i + 1]
  ]
  let i 0
  let actionList (list)
  repeat nr-of-actions [
    set actionList lput (k * i) actionList

    set i i + 1
  ]
  show actionList
end

to step
  ask turtles [
    move
  ]
  tick
  do-plotting
end

to move
  decide-heading
  forward speed
  let collision false

  set collision count turtles in-radius radius > 1

  if-else collision [
    back speed
    updateScore R2 heading
  ] ; else
  [
    updateScore R1 heading
  ]

end

to decide-heading
  let maxx item 0 (table:get dict 0)
  let i 1
  let n 1

  repeat nr-of-actions - 1[
    let val (item 0 (table:get dict (i * k)))
    if val = maxx [
     set n (n + 1)
    ]
    if val > maxx [
     set maxx val
     set n 1
    ]
    set i (i + 1)
  ]

  set i 0
  let arg 0
  let r (random n)
  let ith  0
  repeat nr-of-actions [
    let val (item 0 (table:get dict (i * k)))
    if val = maxx [
      if ith = r [
        set arg (i * k)
      ]
      set ith (ith + 1)
    ]
    set i (i + 1)
  ]

  set heading arg
end

to updateScore [score key]
  let old-tuple table:get dict key
  let newN  item 1 old-tuple + 1
  let new-average ( item 1 old-tuple * item 0 old-tuple + score ) / newN
  let new-tuple list new-average newN
  table:put dict key new-tuple
end

to do-plotting
  set-current-plot "Average reward per direction over time"
  let i 0
  repeat nr-of-actions [
    let penstring word "pen-" i
    set-current-plot-pen penstring
    set-plot-pen-color i * 5 + 3
    ;plotxy ticks count turtles with [heading = i * k]

    let aggr-expected-value 0
    ask turtles[
     set aggr-expected-value aggr-expected-value + (item 0 (table:get dict (i * k)))
    ]

    plotxy ticks (aggr-expected-value / nr-of-skaters)
    set i i + 1
  ]


  set-current-plot "Number of agents per direction over time"
  set i 0
  repeat nr-of-actions [
    let penstring word "pen-" i
    set-current-plot-pen penstring
    set-plot-pen-color i * 5 + 3
    plotxy ticks count turtles with [heading = i * k]
    set i i + 1
  ]
end
@#$#@#$#@
GRAPHICS-WINDOW
817
21
1330
535
-1
-1
5.0
1
10
1
1
1
0
1
1
1
-50
50
-50
50
0
0
1
ticks
30.0

BUTTON
76
39
149
72
NIL
setup
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
78
92
142
125
NIL
step
NIL
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

BUTTON
78
144
141
177
go
step
T
1
T
OBSERVER
NIL
NIL
NIL
NIL
1

SLIDER
220
29
392
62
nr-of-skaters
nr-of-skaters
0
100
25.0
1
1
NIL
HORIZONTAL

SLIDER
220
73
392
106
speed
speed
0
10
10.0
1
1
NIL
HORIZONTAL

SLIDER
221
118
393
151
k
k
0
100
60.0
5
1
NIL
HORIZONTAL

SLIDER
222
160
394
193
R1
R1
0
100
10.0
1
1
NIL
HORIZONTAL

SLIDER
412
160
584
193
R2
R2
0
100
1.0
1
1
NIL
HORIZONTAL

SLIDER
416
63
588
96
radius
radius
0
20
10.0
1
1
NIL
HORIZONTAL

PLOT
25
200
418
539
Average reward per direction over time
Time (in Seconds)
Average reward
0.0
60000.0
0.0
20.0
false
false
"" ""
PENS
"pen-0" 1.0 0 -7500403 true "" ""
"pen-1" 1.0 0 -2674135 true "" ""
"pen-2" 1.0 0 -955883 true "" ""
"pen-3" 1.0 0 -6459832 true "" ""
"pen-4" 1.0 0 -1184463 true "" ""
"pen-5" 1.0 0 -10899396 true "" ""
"pen-6" 1.0 0 -13840069 true "" ""
"pen-7" 1.0 0 -14835848 true "" ""
"pen-8" 1.0 0 -11221820 true "" ""
"pen-9" 1.0 0 -13791810 true "" ""
"pen-10" 1.0 0 -13345367 true "" ""
"pen-11" 1.0 0 -8630108 true "" ""
"pen-12" 1.0 0 -5825686 true "" ""
"pen-13" 1.0 0 -2064490 true "" ""
"pen-14" 1.0 0 -16777216 true "" ""
"pen-15" 1.0 0 -16777216 true "" ""
"pen-16" 1.0 0 -16777216 true "" ""
"pen-17" 1.0 0 -16777216 true "" ""
"pen-18" 1.0 0 -16777216 true "" ""
"pen-19" 1.0 0 -16777216 true "" ""
"pen-20" 1.0 0 -16777216 true "" ""
"pen-21" 1.0 0 -16777216 true "" ""
"pen-22" 1.0 0 -16777216 true "" ""
"pen-23" 1.0 0 -16777216 true "" ""
"pen-24" 1.0 0 -16777216 true "" ""
"pen-25" 1.0 0 -16777216 true "" ""
"pen-26" 1.0 0 -16777216 true "" ""
"pen-27" 1.0 0 -16777216 true "" ""
"pen-28" 1.0 0 -16777216 true "" ""
"pen-29" 1.0 0 -16777216 true "" ""
"pen-30" 1.0 0 -16777216 true "" ""
"pen-31" 1.0 0 -16777216 true "" ""
"pen-32" 1.0 0 -16777216 true "" ""
"pen-33" 1.0 0 -16777216 true "" ""
"pen-34" 1.0 0 -16777216 true "" ""
"pen-35" 1.0 0 -16777216 true "" ""
"pen-36" 1.0 0 -16777216 true "" ""
"pen-37" 1.0 0 -16777216 true "" ""
"pen-38" 1.0 0 -16777216 true "" ""
"pen-39" 1.0 0 -16777216 true "" ""
"pen-40" 1.0 0 -16777216 true "" ""
"pen-41" 1.0 0 -16777216 true "" ""
"pen-42" 1.0 0 -16777216 true "" ""
"pen-43" 1.0 0 -16777216 true "" ""
"pen-44" 1.0 0 -16777216 true "" ""
"pen-45" 1.0 0 -16777216 true "" ""
"pen-46" 1.0 0 -16777216 true "" ""
"pen-47" 1.0 0 -16777216 true "" ""
"pen-48" 1.0 0 -16777216 true "" ""
"pen-49" 1.0 0 -16777216 true "" ""
"pen-50" 1.0 0 -16777216 true "" ""
"pen-51" 1.0 0 -16777216 true "" ""
"pen-52" 1.0 0 -16777216 true "" ""
"pen-53" 1.0 0 -16777216 true "" ""
"pen-54" 1.0 0 -16777216 true "" ""
"pen-55" 1.0 0 -16777216 true "" ""
"pen-56" 1.0 0 -16777216 true "" ""
"pen-57" 1.0 0 -16777216 true "" ""
"pen-58" 1.0 0 -16777216 true "" ""
"pen-59" 1.0 0 -16777216 true "" ""
"pen-60" 1.0 0 -16777216 true "" ""
"pen-61" 1.0 0 -16777216 true "" ""
"pen-62" 1.0 0 -16777216 true "" ""
"pen-63" 1.0 0 -16777216 true "" ""
"pen-64" 1.0 0 -16777216 true "" ""
"pen-65" 1.0 0 -16777216 true "" ""
"pen-66" 1.0 0 -16777216 true "" ""
"pen-67" 1.0 0 -16777216 true "" ""
"pen-68" 1.0 0 -16777216 true "" ""
"pen-69" 1.0 0 -16777216 true "" ""
"pen-70" 1.0 0 -16777216 true "" ""
"pen-71" 1.0 0 -16777216 true "" ""
"pen-72" 1.0 0 -16777216 true "" ""
"pen-73" 1.0 0 -16777216 true "" ""
"pen-74" 1.0 0 -16777216 true "" ""
"pen-75" 1.0 0 -16777216 true "" ""
"pen-76" 1.0 0 -16777216 true "" ""
"pen-77" 1.0 0 -16777216 true "" ""
"pen-78" 1.0 0 -16777216 true "" ""
"pen-79" 1.0 0 -16777216 true "" ""
"pen-80" 1.0 0 -16777216 true "" ""
"pen-81" 1.0 0 -16777216 true "" ""
"pen-82" 1.0 0 -16777216 true "" ""
"pen-83" 1.0 0 -16777216 true "" ""
"pen-84" 1.0 0 -16777216 true "" ""
"pen-85" 1.0 0 -16777216 true "" ""
"pen-86" 1.0 0 -16777216 true "" ""
"pen-87" 1.0 0 -16777216 true "" ""
"pen-88" 1.0 0 -16777216 true "" ""
"pen-89" 1.0 0 -16777216 true "" ""
"pen-90" 1.0 0 -16777216 true "" ""
"pen-91" 1.0 0 -16777216 true "" ""
"pen-92" 1.0 0 -16777216 true "" ""
"pen-93" 1.0 0 -16777216 true "" ""
"pen-94" 1.0 0 -16777216 true "" ""
"pen-95" 1.0 0 -16777216 true "" ""
"pen-96" 1.0 0 -16777216 true "" ""
"pen-97" 1.0 0 -16777216 true "" ""
"pen-98" 1.0 0 -16777216 true "" ""
"pen-99" 1.0 0 -16777216 true "" ""
"pen-100" 1.0 0 -16777216 true "" ""
"pen-101" 1.0 0 -16777216 true "" ""
"pen-102" 1.0 0 -16777216 true "" ""
"pen-103" 1.0 0 -16777216 true "" ""
"pen-104" 1.0 0 -16777216 true "" ""
"pen-105" 1.0 0 -16777216 true "" ""
"pen-106" 1.0 0 -16777216 true "" ""
"pen-107" 1.0 0 -16777216 true "" ""
"pen-108" 1.0 0 -16777216 true "" ""
"pen-109" 1.0 0 -16777216 true "" ""
"pen-110" 1.0 0 -16777216 true "" ""
"pen-111" 1.0 0 -16777216 true "" ""
"pen-112" 1.0 0 -16777216 true "" ""
"pen-113" 1.0 0 -16777216 true "" ""
"pen-114" 1.0 0 -16777216 true "" ""
"pen-115" 1.0 0 -16777216 true "" ""
"pen-116" 1.0 0 -16777216 true "" ""
"pen-117" 1.0 0 -16777216 true "" ""
"pen-118" 1.0 0 -16777216 true "" ""
"pen-119" 1.0 0 -16777216 true "" ""
"pen-120" 1.0 0 -16777216 true "" ""
"pen-121" 1.0 0 -16777216 true "" ""
"pen-122" 1.0 0 -16777216 true "" ""
"pen-123" 1.0 0 -16777216 true "" ""
"pen-124" 1.0 0 -16777216 true "" ""
"pen-125" 1.0 0 -16777216 true "" ""
"pen-126" 1.0 0 -16777216 true "" ""
"pen-127" 1.0 0 -16777216 true "" ""
"pen-128" 1.0 0 -16777216 true "" ""
"pen-129" 1.0 0 -16777216 true "" ""
"pen-130" 1.0 0 -16777216 true "" ""
"pen-131" 1.0 0 -16777216 true "" ""
"pen-132" 1.0 0 -16777216 true "" ""
"pen-133" 1.0 0 -16777216 true "" ""
"pen-134" 1.0 0 -16777216 true "" ""
"pen-135" 1.0 0 -16777216 true "" ""
"pen-136" 1.0 0 -16777216 true "" ""
"pen-137" 1.0 0 -16777216 true "" ""
"pen-138" 1.0 0 -16777216 true "" ""
"pen-139" 1.0 0 -16777216 true "" ""
"pen-140" 1.0 0 -16777216 true "" ""

PLOT
427
200
809
535
Number of agents per direction over time
Time (in Seconds)
Number of agents
0.0
65000.0
0.0
25.0
false
false
"" ""
PENS
"pen-0" 1.0 0 -7500403 true "" ""
"pen-1" 1.0 0 -2674135 true "" ""
"pen-2" 1.0 0 -955883 true "" ""
"pen-3" 1.0 0 -6459832 true "" ""
"pen-4" 1.0 0 -1184463 true "" ""
"pen-5" 1.0 0 -10899396 true "" ""
"pen-6" 1.0 0 -13840069 true "" ""
"pen-7" 1.0 0 -14835848 true "" ""
"pen-8" 1.0 0 -11221820 true "" ""
"pen-9" 1.0 0 -13791810 true "" ""
"pen-10" 1.0 0 -13345367 true "" ""
"pen-11" 1.0 0 -8630108 true "" ""
"pen-12" 1.0 0 -5825686 true "" ""
"pen-13" 1.0 0 -2064490 true "" ""
"pen-14" 1.0 0 -16777216 true "" ""
"pen-15" 1.0 0 -16777216 true "" ""
"pen-16" 1.0 0 -16777216 true "" ""
"pen-17" 1.0 0 -16777216 true "" ""
"pen-18" 1.0 0 -16777216 true "" ""
"pen-19" 1.0 0 -16777216 true "" ""
"pen-20" 1.0 0 -16777216 true "" ""
"pen-21" 1.0 0 -16777216 true "" ""
"pen-22" 1.0 0 -16777216 true "" ""
"pen-23" 1.0 0 -16777216 true "" ""
"pen-24" 1.0 0 -16777216 true "" ""
"pen-25" 1.0 0 -16777216 true "" ""
"pen-26" 1.0 0 -16777216 true "" ""
"pen-27" 1.0 0 -16777216 true "" ""
"pen-28" 1.0 0 -16777216 true "" ""
"pen-29" 1.0 0 -16777216 true "" ""
"pen-30" 1.0 0 -16777216 true "" ""
"pen-31" 1.0 0 -16777216 true "" ""
"pen-32" 1.0 0 -16777216 true "" ""
"pen-33" 1.0 0 -16777216 true "" ""
"pen-34" 1.0 0 -16777216 true "" ""
"pen-35" 1.0 0 -16777216 true "" ""
"pen-36" 1.0 0 -16777216 true "" ""
"pen-37" 1.0 0 -16777216 true "" ""
"pen-38" 1.0 0 -16777216 true "" ""
"pen-39" 1.0 0 -16777216 true "" ""
"pen-40" 1.0 0 -16777216 true "" ""
"pen-41" 1.0 0 -16777216 true "" ""
"pen-42" 1.0 0 -16777216 true "" ""
"pen-43" 1.0 0 -16777216 true "" ""
"pen-44" 1.0 0 -16777216 true "" ""
"pen-45" 1.0 0 -16777216 true "" ""
"pen-46" 1.0 0 -16777216 true "" ""
"pen-47" 1.0 0 -16777216 true "" ""
"pen-48" 1.0 0 -16777216 true "" ""
"pen-49" 1.0 0 -16777216 true "" ""
"pen-50" 1.0 0 -16777216 true "" ""
"pen-51" 1.0 0 -16777216 true "" ""
"pen-52" 1.0 0 -16777216 true "" ""
"pen-53" 1.0 0 -16777216 true "" ""
"pen-54" 1.0 0 -16777216 true "" ""
"pen-55" 1.0 0 -16777216 true "" ""
"pen-56" 1.0 0 -16777216 true "" ""
"pen-57" 1.0 0 -16777216 true "" ""
"pen-58" 1.0 0 -16777216 true "" ""
"pen-59" 1.0 0 -16777216 true "" ""
"pen-60" 1.0 0 -16777216 true "" ""
"pen-61" 1.0 0 -16777216 true "" ""
"pen-62" 1.0 0 -16777216 true "" ""
"pen-63" 1.0 0 -16777216 true "" ""
"pen-64" 1.0 0 -16777216 true "" ""
"pen-65" 1.0 0 -16777216 true "" ""
"pen-66" 1.0 0 -16777216 true "" ""
"pen-67" 1.0 0 -16777216 true "" ""
"pen-68" 1.0 0 -16777216 true "" ""
"pen-69" 1.0 0 -16777216 true "" ""
"pen-70" 1.0 0 -16777216 true "" ""
"pen-71" 1.0 0 -16777216 true "" ""
"pen-72" 1.0 0 -16777216 true "" ""
"pen-73" 1.0 0 -16777216 true "" ""
"pen-74" 1.0 0 -16777216 true "" ""
"pen-75" 1.0 0 -16777216 true "" ""
"pen-76" 1.0 0 -16777216 true "" ""
"pen-77" 1.0 0 -16777216 true "" ""
"pen-78" 1.0 0 -16777216 true "" ""
"pen-79" 1.0 0 -16777216 true "" ""
"pen-80" 1.0 0 -16777216 true "" ""
"pen-81" 1.0 0 -16777216 true "" ""
"pen-82" 1.0 0 -16777216 true "" ""
"pen-83" 1.0 0 -16777216 true "" ""
"pen-84" 1.0 0 -16777216 true "" ""
"pen-85" 1.0 0 -16777216 true "" ""
"pen-86" 1.0 0 -16777216 true "" ""
"pen-87" 1.0 0 -16777216 true "" ""
"pen-88" 1.0 0 -16777216 true "" ""
"pen-89" 1.0 0 -16777216 true "" ""
"pen-90" 1.0 0 -16777216 true "" ""
"pen-91" 1.0 0 -16777216 true "" ""
"pen-92" 1.0 0 -16777216 true "" ""
"pen-93" 1.0 0 -16777216 true "" ""
"pen-94" 1.0 0 -16777216 true "" ""
"pen-95" 1.0 0 -16777216 true "" ""
"pen-96" 1.0 0 -16777216 true "" ""
"pen-97" 1.0 0 -16777216 true "" ""
"pen-98" 1.0 0 -16777216 true "" ""
"pen-99" 1.0 0 -16777216 true "" ""
"pen-100" 1.0 0 -16777216 true "" ""
"pen-101" 1.0 0 -16777216 true "" ""
"pen-102" 1.0 0 -16777216 true "" ""
"pen-103" 1.0 0 -16777216 true "" ""
"pen-104" 1.0 0 -16777216 true "" ""
"pen-105" 1.0 0 -16777216 true "" ""
"pen-106" 1.0 0 -16777216 true "" ""
"pen-107" 1.0 0 -16777216 true "" ""
"pen-108" 1.0 0 -16777216 true "" ""
"pen-109" 1.0 0 -16777216 true "" ""
"pen-110" 1.0 0 -16777216 true "" ""
"pen-111" 1.0 0 -16777216 true "" ""
"pen-112" 1.0 0 -16777216 true "" ""
"pen-113" 1.0 0 -16777216 true "" ""
"pen-114" 1.0 0 -16777216 true "" ""
"pen-115" 1.0 0 -16777216 true "" ""
"pen-116" 1.0 0 -16777216 true "" ""
"pen-117" 1.0 0 -16777216 true "" ""
"pen-118" 1.0 0 -16777216 true "" ""
"pen-119" 1.0 0 -16777216 true "" ""
"pen-120" 1.0 0 -16777216 true "" ""
"pen-121" 1.0 0 -16777216 true "" ""
"pen-122" 1.0 0 -16777216 true "" ""
"pen-123" 1.0 0 -16777216 true "" ""
"pen-124" 1.0 0 -16777216 true "" ""
"pen-125" 1.0 0 -16777216 true "" ""
"pen-126" 1.0 0 -16777216 true "" ""
"pen-127" 1.0 0 -16777216 true "" ""
"pen-128" 1.0 0 -16777216 true "" ""
"pen-129" 1.0 0 -16777216 true "" ""
"pen-130" 1.0 0 -16777216 true "" ""
"pen-131" 1.0 0 -16777216 true "" ""
"pen-132" 1.0 0 -16777216 true "" ""
"pen-133" 1.0 0 -16777216 true "" ""
"pen-134" 1.0 0 -16777216 true "" ""
"pen-135" 1.0 0 -16777216 true "" ""
"pen-136" 1.0 0 -16777216 true "" ""
"pen-137" 1.0 0 -16777216 true "" ""
"pen-138" 1.0 0 -16777216 true "" ""
"pen-139" 1.0 0 -16777216 true "" ""
"pen-140" 1.0 0 -16777216 true "" ""
"pen-141" 1.0 0 -16777216 true "" ""
"pen-142" 1.0 0 -16777216 true "" ""
"pen-143" 1.0 0 -16777216 true "" ""
"pen-144" 1.0 0 -16777216 true "" ""

SLIDER
413
116
663
149
unreasonably-high-number
unreasonably-high-number
800
2000
1000.0
100
1
NIL
HORIZONTAL

@#$#@#$#@
## WHAT IS IT?

(a general understanding of what the model is trying to show or explain)

## HOW IT WORKS

(what rules the agents use to create the overall behavior of the model)

## HOW TO USE IT

(how to use the model, including a description of each of the items in the Interface tab)

## THINGS TO NOTICE

(suggested things for the user to notice while running the model)

## THINGS TO TRY

(suggested things for the user to try to do (move sliders, switches, etc.) with the model)

## EXTENDING THE MODEL

(suggested things to add or change in the Code tab to make the model more complicated, detailed, accurate, etc.)

## NETLOGO FEATURES

(interesting or unusual features of NetLogo that the model uses, particularly in the Code tab; or where workarounds were needed for missing features)

## RELATED MODELS

(models in the NetLogo Models Library and elsewhere which are of related interest)

## CREDITS AND REFERENCES

(a reference to the model's URL on the web if it has one, as well as any other necessary credits, citations, and links)
@#$#@#$#@
default
true
0
Polygon -7500403 true true 150 5 40 250 150 205 260 250

airplane
true
0
Polygon -7500403 true true 150 0 135 15 120 60 120 105 15 165 15 195 120 180 135 240 105 270 120 285 150 270 180 285 210 270 165 240 180 180 285 195 285 165 180 105 180 60 165 15

arrow
true
0
Polygon -7500403 true true 150 0 0 150 105 150 105 293 195 293 195 150 300 150

box
false
0
Polygon -7500403 true true 150 285 285 225 285 75 150 135
Polygon -7500403 true true 150 135 15 75 150 15 285 75
Polygon -7500403 true true 15 75 15 225 150 285 150 135
Line -16777216 false 150 285 150 135
Line -16777216 false 150 135 15 75
Line -16777216 false 150 135 285 75

bug
true
0
Circle -7500403 true true 96 182 108
Circle -7500403 true true 110 127 80
Circle -7500403 true true 110 75 80
Line -7500403 true 150 100 80 30
Line -7500403 true 150 100 220 30

butterfly
true
0
Polygon -7500403 true true 150 165 209 199 225 225 225 255 195 270 165 255 150 240
Polygon -7500403 true true 150 165 89 198 75 225 75 255 105 270 135 255 150 240
Polygon -7500403 true true 139 148 100 105 55 90 25 90 10 105 10 135 25 180 40 195 85 194 139 163
Polygon -7500403 true true 162 150 200 105 245 90 275 90 290 105 290 135 275 180 260 195 215 195 162 165
Polygon -16777216 true false 150 255 135 225 120 150 135 120 150 105 165 120 180 150 165 225
Circle -16777216 true false 135 90 30
Line -16777216 false 150 105 195 60
Line -16777216 false 150 105 105 60

car
false
0
Polygon -7500403 true true 300 180 279 164 261 144 240 135 226 132 213 106 203 84 185 63 159 50 135 50 75 60 0 150 0 165 0 225 300 225 300 180
Circle -16777216 true false 180 180 90
Circle -16777216 true false 30 180 90
Polygon -16777216 true false 162 80 132 78 134 135 209 135 194 105 189 96 180 89
Circle -7500403 true true 47 195 58
Circle -7500403 true true 195 195 58

circle
false
0
Circle -7500403 true true 0 0 300

circle 2
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240

cow
false
0
Polygon -7500403 true true 200 193 197 249 179 249 177 196 166 187 140 189 93 191 78 179 72 211 49 209 48 181 37 149 25 120 25 89 45 72 103 84 179 75 198 76 252 64 272 81 293 103 285 121 255 121 242 118 224 167
Polygon -7500403 true true 73 210 86 251 62 249 48 208
Polygon -7500403 true true 25 114 16 195 9 204 23 213 25 200 39 123

cylinder
false
0
Circle -7500403 true true 0 0 300

dot
false
0
Circle -7500403 true true 90 90 120

face happy
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 255 90 239 62 213 47 191 67 179 90 203 109 218 150 225 192 218 210 203 227 181 251 194 236 217 212 240

face neutral
false
0
Circle -7500403 true true 8 7 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Rectangle -16777216 true false 60 195 240 225

face sad
false
0
Circle -7500403 true true 8 8 285
Circle -16777216 true false 60 75 60
Circle -16777216 true false 180 75 60
Polygon -16777216 true false 150 168 90 184 62 210 47 232 67 244 90 220 109 205 150 198 192 205 210 220 227 242 251 229 236 206 212 183

fish
false
0
Polygon -1 true false 44 131 21 87 15 86 0 120 15 150 0 180 13 214 20 212 45 166
Polygon -1 true false 135 195 119 235 95 218 76 210 46 204 60 165
Polygon -1 true false 75 45 83 77 71 103 86 114 166 78 135 60
Polygon -7500403 true true 30 136 151 77 226 81 280 119 292 146 292 160 287 170 270 195 195 210 151 212 30 166
Circle -16777216 true false 215 106 30

flag
false
0
Rectangle -7500403 true true 60 15 75 300
Polygon -7500403 true true 90 150 270 90 90 30
Line -7500403 true 75 135 90 135
Line -7500403 true 75 45 90 45

flower
false
0
Polygon -10899396 true false 135 120 165 165 180 210 180 240 150 300 165 300 195 240 195 195 165 135
Circle -7500403 true true 85 132 38
Circle -7500403 true true 130 147 38
Circle -7500403 true true 192 85 38
Circle -7500403 true true 85 40 38
Circle -7500403 true true 177 40 38
Circle -7500403 true true 177 132 38
Circle -7500403 true true 70 85 38
Circle -7500403 true true 130 25 38
Circle -7500403 true true 96 51 108
Circle -16777216 true false 113 68 74
Polygon -10899396 true false 189 233 219 188 249 173 279 188 234 218
Polygon -10899396 true false 180 255 150 210 105 210 75 240 135 240

house
false
0
Rectangle -7500403 true true 45 120 255 285
Rectangle -16777216 true false 120 210 180 285
Polygon -7500403 true true 15 120 150 15 285 120
Line -16777216 false 30 120 270 120

leaf
false
0
Polygon -7500403 true true 150 210 135 195 120 210 60 210 30 195 60 180 60 165 15 135 30 120 15 105 40 104 45 90 60 90 90 105 105 120 120 120 105 60 120 60 135 30 150 15 165 30 180 60 195 60 180 120 195 120 210 105 240 90 255 90 263 104 285 105 270 120 285 135 240 165 240 180 270 195 240 210 180 210 165 195
Polygon -7500403 true true 135 195 135 240 120 255 105 255 105 285 135 285 165 240 165 195

line
true
0
Line -7500403 true 150 0 150 300

line half
true
0
Line -7500403 true 150 0 150 150

pentagon
false
0
Polygon -7500403 true true 150 15 15 120 60 285 240 285 285 120

person
false
0
Circle -7500403 true true 110 5 80
Polygon -7500403 true true 105 90 120 195 90 285 105 300 135 300 150 225 165 300 195 300 210 285 180 195 195 90
Rectangle -7500403 true true 127 79 172 94
Polygon -7500403 true true 195 90 240 150 225 180 165 105
Polygon -7500403 true true 105 90 60 150 75 180 135 105

plant
false
0
Rectangle -7500403 true true 135 90 165 300
Polygon -7500403 true true 135 255 90 210 45 195 75 255 135 285
Polygon -7500403 true true 165 255 210 210 255 195 225 255 165 285
Polygon -7500403 true true 135 180 90 135 45 120 75 180 135 210
Polygon -7500403 true true 165 180 165 210 225 180 255 120 210 135
Polygon -7500403 true true 135 105 90 60 45 45 75 105 135 135
Polygon -7500403 true true 165 105 165 135 225 105 255 45 210 60
Polygon -7500403 true true 135 90 120 45 150 15 180 45 165 90

sheep
false
15
Circle -1 true true 203 65 88
Circle -1 true true 70 65 162
Circle -1 true true 150 105 120
Polygon -7500403 true false 218 120 240 165 255 165 278 120
Circle -7500403 true false 214 72 67
Rectangle -1 true true 164 223 179 298
Polygon -1 true true 45 285 30 285 30 240 15 195 45 210
Circle -1 true true 3 83 150
Rectangle -1 true true 65 221 80 296
Polygon -1 true true 195 285 210 285 210 240 240 210 195 210
Polygon -7500403 true false 276 85 285 105 302 99 294 83
Polygon -7500403 true false 219 85 210 105 193 99 201 83

square
false
0
Rectangle -7500403 true true 30 30 270 270

square 2
false
0
Rectangle -7500403 true true 30 30 270 270
Rectangle -16777216 true false 60 60 240 240

star
false
0
Polygon -7500403 true true 151 1 185 108 298 108 207 175 242 282 151 216 59 282 94 175 3 108 116 108

target
false
0
Circle -7500403 true true 0 0 300
Circle -16777216 true false 30 30 240
Circle -7500403 true true 60 60 180
Circle -16777216 true false 90 90 120
Circle -7500403 true true 120 120 60

tree
false
0
Circle -7500403 true true 118 3 94
Rectangle -6459832 true false 120 195 180 300
Circle -7500403 true true 65 21 108
Circle -7500403 true true 116 41 127
Circle -7500403 true true 45 90 120
Circle -7500403 true true 104 74 152

triangle
false
0
Polygon -7500403 true true 150 30 15 255 285 255

triangle 2
false
0
Polygon -7500403 true true 150 30 15 255 285 255
Polygon -16777216 true false 151 99 225 223 75 224

truck
false
0
Rectangle -7500403 true true 4 45 195 187
Polygon -7500403 true true 296 193 296 150 259 134 244 104 208 104 207 194
Rectangle -1 true false 195 60 195 105
Polygon -16777216 true false 238 112 252 141 219 141 218 112
Circle -16777216 true false 234 174 42
Rectangle -7500403 true true 181 185 214 194
Circle -16777216 true false 144 174 42
Circle -16777216 true false 24 174 42
Circle -7500403 false true 24 174 42
Circle -7500403 false true 144 174 42
Circle -7500403 false true 234 174 42

turtle
true
0
Polygon -10899396 true false 215 204 240 233 246 254 228 266 215 252 193 210
Polygon -10899396 true false 195 90 225 75 245 75 260 89 269 108 261 124 240 105 225 105 210 105
Polygon -10899396 true false 105 90 75 75 55 75 40 89 31 108 39 124 60 105 75 105 90 105
Polygon -10899396 true false 132 85 134 64 107 51 108 17 150 2 192 18 192 52 169 65 172 87
Polygon -10899396 true false 85 204 60 233 54 254 72 266 85 252 107 210
Polygon -7500403 true true 119 75 179 75 209 101 224 135 220 225 175 261 128 261 81 224 74 135 88 99

wheel
false
0
Circle -7500403 true true 3 3 294
Circle -16777216 true false 30 30 240
Line -7500403 true 150 285 150 15
Line -7500403 true 15 150 285 150
Circle -7500403 true true 120 120 60
Line -7500403 true 216 40 79 269
Line -7500403 true 40 84 269 221
Line -7500403 true 40 216 269 79
Line -7500403 true 84 40 221 269

wolf
false
0
Polygon -16777216 true false 253 133 245 131 245 133
Polygon -7500403 true true 2 194 13 197 30 191 38 193 38 205 20 226 20 257 27 265 38 266 40 260 31 253 31 230 60 206 68 198 75 209 66 228 65 243 82 261 84 268 100 267 103 261 77 239 79 231 100 207 98 196 119 201 143 202 160 195 166 210 172 213 173 238 167 251 160 248 154 265 169 264 178 247 186 240 198 260 200 271 217 271 219 262 207 258 195 230 192 198 210 184 227 164 242 144 259 145 284 151 277 141 293 140 299 134 297 127 273 119 270 105
Polygon -7500403 true true -1 195 14 180 36 166 40 153 53 140 82 131 134 133 159 126 188 115 227 108 236 102 238 98 268 86 269 92 281 87 269 103 269 113

x
false
0
Polygon -7500403 true true 270 75 225 30 30 225 75 270
Polygon -7500403 true true 30 75 75 30 270 225 225 270
@#$#@#$#@
NetLogo 6.0.1
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
@#$#@#$#@
default
0.0
-0.2 0 0.0 1.0
0.0 1 1.0 0.0
0.2 0 0.0 1.0
link direction
true
0
Line -7500403 true 150 150 90 180
Line -7500403 true 150 150 210 180
@#$#@#$#@
0
@#$#@#$#@
