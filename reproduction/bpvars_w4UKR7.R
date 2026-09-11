
library(bpvars)


# Benchmark model
c_select = c("UKR","FRA","ESP","SWE","NOR","DEU","FIN","POL","ITA","GBR")

spec = specify_bvarPANEL$new(ilo_dynamic_panel[c_select])   # specify the model
poos = specify_poosf_exercise$new(                # specify forecasting exercise
  spec,
  S = 1000,
  S_burn = 1000,
  horizons = 1,
  training_sample = 30
)
fore = forecast_poos_recursively(spec, poos)      # run the forecasting exercise 
fper = compute_forecast_performance(fore)         # compute performance metrics 

# country-grouping model
spec_g = specify_bvarGroupPANEL$new(                # specify the model
  ilo_dynamic_panel[c_select],
  group_allocation = c(1,2,2,1,2,2,1,1,2,2)
)
poos_g = specify_poosf_exercise$new(                # specify forecasting exercise
  spec_g,
  S = 1000,
  S_burn = 1000,
  horizons = 1,
  training_sample = 30
)
fore_g = forecast_poos_recursively(spec_g, poos_g)  # run the forecasting exercise 
fper_g = compute_forecast_performance(fore_g)       # compute performance metrics 


# density forecast performance comparison
cbind(fper$PLS$Global, fper_g$PLS$Global)

# point forecast performance comparison
cbind(fper$RMSFE$Global, fper_g$RMSFE$Global)
