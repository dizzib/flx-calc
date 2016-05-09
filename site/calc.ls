window.calc = ->
  const G             = 9.81 # m/s^2
  const KG-PER-GRAM   = 0.001
  const METRES-PER-MM = 0.001
  const MM-PER-METRE  = 1000
  const PI            = 3.14159265

  # line properties at zero-tension T0
  r = METRES-PER-MM * it.d / 2  # radius (m)
  a = PI * r^2  # cross-section area (m^2)
  v_s = a * it.l_s  # sample volume (m^3)
  rho_l = KG-PER-GRAM * it.m_s / v_s # density (kg per m^3)

  # line properties at max-tension Tmax
  lai = it.x + it.l_i # total line length from anchor to indicator (m)
  dl-ratio = it.dl_i / lai # line stretch ratio
  dd = - it.nu * it.d * dl-ratio # diameter change (mm) using Poisson ratio
  r_T = METRES-PER-MM * (it.d + dd) / 2  # radius (m)
  a_T = PI * r_T^2  # cross-section area (m^2)
  v_sT = a_T * it.l_s * (1 + dl-ratio) # stretched sample volume (m^3)
  rho_lT = KG-PER-GRAM * it.m_s / v_sT # stretched sample density (kg per m^3)

  # sag at Tmax
  v_T = a_T * x # volume of water displaced
  b_T = it.rho_w * v_T * G # buoyancy
  w_T = rho_lT * v_T * G # weight

  # outs
  dd:dd
  lai:lai
  r:r * MM-PER-METRE
  rho_l:rho_l
  rho_lT:rho_lT
