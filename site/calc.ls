window.calc = ->
  const KG-PER-GRAM   = 0.001
  const METRES-PER-MM = 0.001
  const PI            = 3.14159265

  # unstretched line properties
  r = METRES-PER-MM * it.d / 2  # radius (m)
  a = PI * r^2  # cross sectional area (m^2)
  v = a * it.x  # volume between the poles (m^3)
  rho-l = KG-PER-GRAM * it.m_s / v  # density (kg per m^3)

  rho_l: rho-l
