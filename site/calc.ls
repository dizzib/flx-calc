window.calc = ->
  const EARTH-RADIUS   = 6371km * 1000m
  const G              = 9.81 # acceleration due to gravity (m/s^2)
  const KG-PER-GRAM    = 0.001
  const METRES-PER-MM  = 0.001
  const MICRONS-PER-MM = 1000
  const MM-PER-METRE   = 1000
  const MM-PER-MICRON  = 0.001
  const NU-H2O         = 1.081 * 10^-6 # kinematic viscosity of water at 17C (m^2/s)
  const PI             = 3.14159265
  const SECS-PER-MIN   = 60

  # line properties at zero-tension T0
  it.d *= MICRONS-PER-MM if it.d < 10 # auto-convert mm to microns
  r = METRES-PER-MM * MM-PER-MICRON * it.d / 2  # radius (m)
  a = PI * r^2  # cross-section area (m^2)
  vol_s = a * it.l_s  # sample volume (m^3)
  rho_l = KG-PER-GRAM * it.m_s / vol_s # density (kg per m^3)
  it.rho_w = rho_l if it.nb # set water density if neutral buoyancy

  # line properties at max-tension Tmax
  it.d_T *= MICRONS-PER-MM if it.d_T < 10 # auto-convert mm to microns
  d_T = METRES-PER-MM * MM-PER-MICRON * it.d_T # diameter (m)
  r_T = d_T / 2 # radius (m)
  a_T = PI * r_T^2  # cross-section area (m^2)
  l = it.x + it.l_o # total line length from anchor to indicator (m)
  dl-ratio = it.dl / l # line stretch ratio
  vol_sT = a_T * it.l_s * (1 + dl-ratio) # stretched sample volume (m^3)
  rho_lT = KG-PER-GRAM * it.m_s / vol_sT # stretched sample density (kg per m^3)
  v-ms = it.v * METRES-PER-MM / SECS-PER-MIN # drift velocity (m per s)
  re = (Math.abs v-ms) * d_T / NU-H2O # Reynolds number -- chord length is line diameter
  c_d = 8 * PI / (re * (2.002 - Math.log re)) # drag coefficient, by Lamb approximation

  # extra info not used in calculation
  dd = it.d_T - it.d # diameter change (mm)
  nu = - dd / (it.d * dl-ratio) # Poisson ratio
  young-mod = it.T_max / (a * dl-ratio) # Young's modulus (Pa)

  # forces acting on a 1 metre portion of line at Tmax
  unit-vol = a_T * 1m # volume of water displaced (m^3)
  unit-b = it.rho_w * unit-vol * G # buoyancy up (N)
  unit-w = rho_lT * unit-vol * G # line weight (N)
  unit-a-proj = d_T * 1m # projected area perpendicular to flow (m^2)
  unit-d = if c_d then it.rho_w * v-ms^2 * c_d * unit-a-proj / 2 else 0 # viscous drag (N)
  unit-d = - unit-d if v-ms < 0 # correct sign for viscous drag down (N)

  # line midpoint sag at Tmax
  factor = it.x^2 / (8 * it.T_max) # parabolic approximation factor (m)
  sag_dl = (unit-w - unit-b) * factor # due to line density change (m)
  sag_v = unit-d * factor # due to prevailing current and/or mis-calibration (m)
  sag = sag_dl + sag_v # total (m)
  sag-mm = sag * MM-PER-METRE # total (mm)

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
  sigma_upc = 100 * sigma_u / sigma_o # measurement uncertainty (% of outlier)

  # alerts
  alert =
    nu:nu < 0.3 or nu > 0.5
    re:re > 1
    rho_l:rho_l < 960 or rho_l > 1600
    rho_lT:rho_lT < 960 or rho_lT > 1600
    sigma_upc:sigma_upc >= 100

  c_d:{val:c_d, alert:alert.re}
  d:it.d
  d_T:it.d_T
  dd:dd
  dl_percent:dl-ratio * 100
  dh:dh-mm
  dY_concave: -dh-mm + sag-mm
  dY_convex: +dh-mm + sag-mm
  dY_flat: 0mm + sag-mm
  E:young-mod / 10^9 # GPa
  nu:{val:nu, alert:alert.nu}
  r:r * MM-PER-METRE
  re:{val:re, alert:alert.re}
  rho_l:{val:rho_l, alert:alert.rho_l}
  rho_lT:{val:rho_lT, alert:alert.rho_lT}
  rho_w:it.rho_w
  sag:sag-mm
  sag_dl:sag_dl * MM-PER-METRE
  sag_v:{val:sag_v * MM-PER-METRE, alert:alert.re}
  sigma_o:sigma_o
  sigma_u:sigma_u
  sigma_upc:{val:Math.round(sigma_upc), alert:alert.sigma_upc}

