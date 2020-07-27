cd "/u/jag6/Thesis"

** import delimited "full_data.csv"

import delimited "state_controls.csv"

**convert variables read in as strings due to commas to numeric**

destring totalpopulation medianhouseholdincome, gen (tot_pop mhinc) ignore(",")

gen veh3plus = v19+v20+ormorevehiclesavailable
gen senior_pop = 1-lessthan55years

rename lessthan18years youth_pop
rename novehicleavailable veh0
rename vehicleavailable veh1
rename vehiclesavailable veh2
rename averagecommutetoworkinmin avg_commute
rename publictransportationincludestaxi took_transit

drop totalpopulation medianhouseholdincome v19 v20 ormorevehiclesavailable
drop lessthan55years

save reg_data_states

