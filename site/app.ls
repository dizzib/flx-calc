# set global log fn
# note we can't just set window.log = console.log becuase we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

const DEFAULT-INS = d:1.1 dl:1.5 x:250 l_o:1 l_s:1 m_s:0.9 nb:true nu:0.46 T_max:1000

$ \input .on \change -> calculate!
$ \#nb .on \change -> set-rho_w-access!

populate-ins DEFAULT-INS
set-rho_w-access!
calculate!

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

function set-rho_w-access
  $ \#rho_w .prop \disabled ($ \#nb .prop \checked)
