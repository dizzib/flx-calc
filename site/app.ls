# set global log fn
# note we can't just set window.log = console.log becuase we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

$ \#d .val 1
$ \#dl .val 0.798
$ \#l .val 250
$ \#li .val 253
$ \#nu-l .val 0.46
$ \#rho-l .val 975
$ \#rho-w .val 1000
$ \#Tmax .val 1000
