# set global log fn
# note we can't just set window.log = console.log becuase we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

$ \#d .val 1.000
$ \#dl_i .val 1.50
$ \#l .val 250.00
$ \#l_i .val 3.00
$ \#l_s .val 280.00
$ \#m_s .val 224.00
$ \#nu .val 0.46
$ \#rho_w .val 1000
$ \#T_max .val 1050
