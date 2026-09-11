
library(bpvars)

# specify the model
c_select = c("UKR","FRA","ESP","SWE","NOR",
             "DEU","FIN","POL","ITA","GBR")

specg = specify_bvarGroupPriorPANEL$new(
  ilo_dynamic_panel[c_select],
  exogenous = ilo_exogenous_variables[c_select],
  group_allocation = c(1,2,2,1,2,2,1,1,2,2)
)

# estimate the model
burng = estimate(specg, S = 5000, show_progress = FALSE)
postg = estimate(burng, S = 5000)

# safe the output
save(
  specg, postg,
  file = "reproduction/bpvars_w4UKR2.rda"
)