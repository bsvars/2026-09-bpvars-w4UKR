
library(bpvars)

# data prep
class(ilo_dynamic_panel); length(ilo_dynamic_panel)
names(ilo_dynamic_panel)[1:8]
class(ilo_dynamic_panel$UKR)
ilo_dynamic_panel$UKR


# specify the model
c_select = c("UKR","FRA","ESP","SWE","NOR","DEU","FIN","POL","ITA","GBR")

spec = specify_bvarPANEL$new(                           # specify the model
  ilo_dynamic_panel[c_select],                          # data
  exogenous = ilo_exogenous_variables[c_select]         # exogenous variables
)

# estimate the model
burn = estimate(spec, S = 5000, show_progress = FALSE) # run the burn-in
post = estimate(burn, S = 5000)                        # estimate the model

# forecast
fore = forecast(                                    # forecast the model
  post,                                             # estimation output
  horizon = 3,                                      # forecast horizon
  exogenous_forecast = ilo_exogenous_forecasts,     # forecasts for exogenous variables
) 
plot(fore, "UKR", main = "Forecasts for Ukraine")  # plot the forecasts


# safe the output
save(
  spec, post, fore,
  file = "reproduction/bpvars_w4UKR1.rda"
)