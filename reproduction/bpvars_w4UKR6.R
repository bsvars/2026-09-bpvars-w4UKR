
library(bpvars)

# specify the model
spec = specify_bvarPANEL$new(
  ilo_dynamic_panel,
  exogenous = ilo_exogenous_variables,
)

# estimation
burn = estimate(spec, S = 5000)
post = estimate(burn, S = 5000)

# forecasting
fore = forecast(
  horizon = 3,
  exogenous_forecast = ilo_exogenous_forecasts,
  conditional_forecast = ilo_conditional_forecasts
)

plot(fore, which_c = "UKR", main = "Conditional forecasts for Ukraine")

# safe the output
save(
  spec, post, fore,
  file = "reproduction/bpvars_w4UKR6.rda"
)