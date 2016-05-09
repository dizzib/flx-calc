window.calc = ->
  const G             = 9.81 # m/s^2
  const KG-PER-GRAM   = 0.001
  const METRES-PER-MM = 0.001
  const MM-PER-METRE  = 1000
  const PI            = 3.14159265

  # line properties at zero-tension
  r = METRES-PER-MM * it.d / 2  # radius (m)
  a = PI * r^2  # cross-section area (m^2)
  v_s = a * it.l_s  # sample volume (m^3)
  rho-l = KG-PER-GRAM * it.m_s / v_s # density (kg per m^3)

  # line properties at max-tension
  lai = it.x + it.l_i # total line length from anchor to indicator (m)
  dl = it.dl_i * it.x / lai # inter-pole line stretch (m)
  dd = - it.nu * it.d * it.dl_i / lai # diameter change (mm) using Poisson ratio

  # outs
  dd:dd
  dl:dl
  lai:lai
  r:r * MM-PER-METRE
  rho_l:rho-l
