# set global log fn
# note we can't just set window.log = console.log becuase we'll get
# 'illegal invocation' errors, since console.log expects 'this' to be console.
window.log = -> console.log ...&

const DEFAULT-INS = d:1.1 dl:1.5 l_o:1 l_s:1 m_s:0.9 nb:true nu:0.46 T_max:1000 uy:0.1 v:0 x:250

$.ajax url:\package.json success:-> $ \#version .text "v#{it.version}"
$ \input .on \change -> calculate!
$ \#nb .on \change -> set-rho_w-access!
$ '.help .link' .on \click -> $ @ .parents \.help .toggleClass 'open closed'

populate-ins get-ins-by-querystring!
set-rho_w-access!
calculate!

function calculate
  ins = {}
  $ 'input[type="checkbox"]' .each -> ins[$ @ .attr \id] = $ @ .prop \checked
  $ 'input[type="text"]' .each -> ins[$ @ .attr \id] = parseFloat($ @ .val!)
  outs = window.calc ins
  for k, v of outs
    $el = $ "##k, .#k"
    if v.val?
      $el.removeClass!addClass v.class
      v = v.val
    v = (Math.round v * 10^4) / 10^4 # round to 4 decimal places
    $el.text(v).val(v)
    ins[k] = v if ins[k] # update (some) ins with rounded outs
  set-querystring-by-ins ins

function get-ins-by-querystring
  ins = DEFAULT-INS
  qs = queryString.parse location.search
  for k, v of qs then ins[k] = if k is \nb then (v is \true) else v
  ins

function populate-ins
  for k, v of it
    t = ($el = $ "##k").attr \type
    if t is \checkbox then ($el.prop \checked v) else $el.val v

function set-rho_w-access
  $ \#rho_w .prop \disabled ($ \#nb .prop \checked)

function set-querystring-by-ins
  qs = queryString.stringify it
  history.replaceState void "" "?#qs"
