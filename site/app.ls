# set global log fn
# note we can't just set window.log = console.log becuase we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

const DEFAULT-INS = d:1.1 dl_i:1.5 x:250 l_i:3 l_s:280 m_s:250 nu:0.46 rho_w:1000 T_max:1050

display-ins DEFAULT-INS
calculate!
$ 'input[type="text"]' .on \change -> calculate!

function calculate
  ins = {}
  $ 'input[type="text"]' .each -> ins[$ @ .attr \id] = parseFloat($ @ .val!)
  outs = window.calc ins
  for k, v of outs then $ "##k" .text v

function display-ins
  for k, v of it then $ "##k" .val v
