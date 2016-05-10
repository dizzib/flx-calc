# set global log fn
# note we can't just set window.log = console.log becuase we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

const DEFAULT-INS = d:1.1 dl_i:1.5 x:250 l_i:3 l_s:280 m_s:250 nb:true nu:0.46 rho_w:1000 T_max:1050

populate-ins DEFAULT-INS
calculate!
$ \input .on \change -> calculate!

function calculate
  ins = {}
  $ 'input[type="checkbox"]' .each -> ins[$ @ .attr \id] = $ @ .prop \checked
  $ 'input[type="text"]' .each -> ins[$ @ .attr \id] = parseFloat($ @ .val!)
  outs = window.calc ins
  for k, v of outs then $ "##k" .text v .val v

function populate-ins
  for k, v of it
    t = ($el = $ "##k").attr \type
    if t is \checkbox then ($el.prop \checked v) else $el.val v
