# set global log fn
# note we can't just set window.log = console.log becuase we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

$ \#d .val 1.005
$ \#dl_i .val 0.79
$ \#l .val 250
$ \#l_i .val 253
$ \#l_s .val 280
$ \#m_s .val 224
$ \#nu .val 0.46
$ \#rho_l .val 975
$ \#rho_w .val 1000
$ \#T_max .val 1000
