
# specification and estimation
ilo_dynamic_panel[c_select] |> 
  specify_bvarPANEL$new(
    exogenous = ilo_exogenous_variables[c_select],
    type = c("real","rate","rate","rate")
  ) |> 
  estimate(S = 5000, show_progress = FALSE) |> 
  estimate(S = 5000, show_progress = FALSE) -> post

# constrained forecasting
post |>
  forecast(
    horizon = 3,
    exogenous_forecast = ilo_exogenous_forecasts,
  ) |> 
  plot(which_c = "POL", main = "Constrained forecasts for Poland")

# conditional forecasting
post |>
  forecast(
    horizon = 3,
    exogenous_forecast = ilo_exogenous_forecasts,
    conditional_forecast = ilo_conditional_forecasts[c_select]
  ) |> 
  plot(which_c = "POL", main = "Conditional forecasts for Poland")

# saving outputs
save(
  post,
  file = "reproduction/bpvars_w4UKR5.rda"
)