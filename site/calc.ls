window.calc = ->
  const EARTH-RADIUS  = 6371km * 1000m
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
  l = it.x + it.l_o # total line length from anchor to indicator (m)
  dl-ratio = it.dl / l # line stretch ratio
  dd = - it.nu * it.d * dl-ratio # diameter change (mm) using Poisson ratio
  r_T = METRES-PER-MM * (it.d + dd) / 2  # radius (m)
  a_T = PI * r_T^2  # cross-section area (m^2)
  v_sT = a_T * it.l_s * (1 + dl-ratio) # stretched sample volume (m^3)
  rho_lT = KG-PER-GRAM * it.m_s / v_sT # stretched sample density (kg per m^3)
  E = it.T_max / (a * dl-ratio) # Young's modulus (Pa)

  # sag at Tmax
  it.rho_w = rho_l if it.nb # set water density if neutral buoyancy
  v1 = a_T * 1m # volume of water displaced per metre of line (m^3)
  b1 = it.rho_w * v1 * G # buoyancy per metre (N)
  w1 = rho_lT * v1 * G # weight per metre (N)
  f1 = w1 - b1 # net vertical force per metre (N)
  y = f1 * it.x^2 / (8 * it.T_max) # sag at the centre (m)

  # earth curve
  x_c = it.x / 2 # distance from line-pole to line-centre (m)
  dh = Math.sqrt(x_c^2 + EARTH-RADIUS^2) - EARTH-RADIUS # water height difference (m)

  # outs
  dd:dd
  dl_percent:dl-ratio * 100
  E:E / 10^9 # GPa
  dh:dh * MM-PER-METRE
  r:r * MM-PER-METRE
  rho_l:rho_l
  rho_lT:rho_lT
  rho_w:it.rho_w
  y:y * MM-PER-METRE
