clear

import delimited "full_data_inflation.csv"

**convert variables read in as strings due to commas to numeric**

destring totalpopulation medianhouseholdincome, gen (tot_pop mhinc) ignore(",")

gen veh3plus = v36+v37+ormorevehiclesavailable
gen senior_pop = 1-lessthan55years

rename lessthan18years youth_pop
rename novehicleavailable veh0
rename vehicleavailable veh1
rename vehiclesavailable veh2
rename averagecommutetoworkinmin avg_commute
rename publictransportationincludestaxi took_transit
rename areatotal area
rename foreignborn forborn

drop totalpopulation medianhouseholdincome v36 v37 ormorevehiclesavailable
drop lessthan55years

gen id = _n
gen month_id = mod(id-1, 12)
drop id

save reg_data_inflation, replace

gen logtrips = log(trips)
gen logprice = log(gprice)
gen logrealprice = log(real_gprice)

label variable logprice "log(Gas Price)"
label variable logtrips "log(UPT)"
label variable logrealprice "log(Real Gas Price)"

gen pop_dens = tot_pop/area
label variable pop_dens "Population Density"
label variable veh0 "No Vehicle HH"
label variable youth_pop "Population under 18"
label variable senior_pop "Population over 55"
label variable forborn "Foreign-born Population"
label variable unemp "Unemployment Rate"

local controlVars pop_dens youth_pop senior_pop unemp mhinc avg_commute veh0 forborn

egen city_id=group(city)
egen year_id=group(year)

reg logtrips logprice i.city_id i.month_id `controlVars'
eststo r1

reg logtrips logrealprice i.city_id i.month_id `controlVars'
eststo r2

outreg2 [r1] using finalInflation.doc, replace label keep(logprice)
outreg2 [r2] using finalInflation.doc, label keep(logrealprice)
