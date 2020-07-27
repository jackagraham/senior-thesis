clear 

use reg_data

** get logs of trips, gas prices

gen pop_dens = tot_pop/area
gen logtrips = log(trips)
gen logprice = log(gprice)
gen log_stateprice = log(stategas)

label variable logprice "log(Gas Price)"
label variable logtrips "log(UPT)"

label variable pop_dens "Population Density"
label variable veh0 "No Vehicle HH"
label variable youth_pop "Population under 18"
label variable senior_pop "Population over 55"
label variable forborn "Foreign-born Population"
label variable unemp "Unemployment Rate"

local controlVars pop_dens youth_pop senior_pop unemp mhinc avg_commute veh0 forborn

keep if city=="NYC" | city=="Boston" | city=="Seattle" | city=="Miami" 

xi: reg logtrips logprice i.city i.month `controlVars'
eststo r1

outreg2 [r1] using finalCats.doc, label replace ctitle(High Transit) keep(logprice `controlVars')

clear 

use reg_data

gen logtrips = log(trips)
gen logprice = log(gprice)
gen log_stateprice = log(stategas)

gen pop_dens = tot_pop/area
label variable logprice "log(Gas Price)"
label variable logtrips "log(UPT)"

label variable pop_dens "Population Density"
label variable veh0 "No Vehicle HH"
label variable youth_pop "Population under 18"
label variable senior_pop "Population over 55"
label variable forborn "Foreign-born Population"
label variable unemp "Unemployment Rate"

local controlVars pop_dens youth_pop senior_pop unemp mhinc avg_commute veh0 forborn

drop if city=="NYC" | city=="Boston" | city=="Seattle" | city=="Miami" 

xi: reg logtrips logprice i.city i.month `controlVars'
eststo r2

outreg2 [r2] using finalCats.doc, label ctitle(Low Transit) keep(logprice `controlVars')


