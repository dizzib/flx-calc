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
  young-mod = it.T_max / (a * dl-ratio) # Young's modulus (Pa) -- not used in calculation

  # line sag at Tmax
  it.rho_w = rho_l if it.nb # set water density if neutral buoyancy
  v1 = a_T * 1m # volume of water displaced per metre of line (m^3)
  b1 = it.rho_w * v1 * G # buoyancy per metre (N)
  w1 = rho_lT * v1 * G # weight per metre (N)
  f1 = w1 - b1 # net vertical force per metre (N)
  sag = f1 * it.x^2 / (8 * it.T_max) # midpoint sag, by parabolic approximation (m)
  sag-mm = sag * MM-PER-METRE # midpoint sag (mm)

  # earth curve
  x_C = it.x / 2 # distance from line pole to midpoint (m)
  dh = Math.sqrt(x_C^2 + EARTH-RADIUS^2) - EARTH-RADIUS # water height difference (m)
  dh-mm = dh * MM-PER-METRE # water height difference (mm)

  # measurement uncertainty analysis
  #
  # The difference in depth between the midpoint and poles is given by:
  #
  #   dY = (y_CL - y_CW) - ((y_AL - y_AW) + (y_BL - y_BW)) / 2
  #
  # where y_** is a single reading
  #       L=line, W=water surface
  #       A=pole-A, B=pole-B, and C=midpoint of L
  #
  uy = it.uy # uncertainty of a single reading (mm)
  u-dY = uy + uy + (uy + uy + uy + uy) / 2 # uncertainty of dY (mm)

  # standard deviations by 3-sigma (99.73%) for a normal distribution
  sigma_o = dh-mm * 0.5 / 3 # outliers, allowing scatter to halfway to next predicted dY (mm)
  sigma_u = u-dY / 3 # measurement uncertainty (mm)
  sigma_u-perc = 100 * sigma_u / sigma_o # measurement uncertainty (% of outlier)

  dd:dd
  dl_percent:dl-ratio * 100
  dh:dh-mm
  dY_concave: -dh-mm + sag-mm
  dY_convex: +dh-mm + sag-mm
  dY_flat: 0mm + sag-mm
  E:young-mod / 10^9 # GPa
  r:r * MM-PER-METRE
  rho_l:rho_l
  rho_lT:rho_lT
  rho_w:it.rho_w
  sag:sag-mm
  sigma_o:sigma_o
  sigma_u:sigma_u
  'sigma_u-perc':Math.round sigma_u-perc
