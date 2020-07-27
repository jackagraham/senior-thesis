clear

use reg_data

** get logs of trips, gas prices

gen logtrips = log(trips)
gen logprice = log(gprice)
gen log_stateprice = log(stategas)

label variable logprice "log(Gas Price)"
label variable logtrips "log(UPT)"

gen pop_dens = tot_pop/area
label variable pop_dens "Population Density"
label variable veh0 "No Vehicle HH"
label variable youth_pop "Population under 18"
label variable senior_pop "Population over 55"
label variable forborn "Foreign-born Population"
label variable unemp "Unemployment Rate"

local controlVars pop_dens youth_pop senior_pop unemp mhinc avg_commute veh0 forborn

reg logtrips logprice `controlVars'
eststo r1

xi: reg logtrips logprice i.city i.year i.month `controlVars'
eststo r2
	
xi: reg logtrips logprice i.month i.year `controlVars'
eststo r3
	
xi: reg logtrips logprice i.city i.year `controlVars'
eststo r4

xi: reg logtrips logprice i.city i.month `controlVars'
eststo r5

xi: reg logtrips logprice i.city `controlVars'
eststo r6

outreg2 [r1] using final_fe.doc, label replace ctitle(No FE) keep(logprice `controlVars')
outreg2 [r2] using final_fe.doc, label ctitle(All FE) keep(logprice `controlVars')
outreg2 [r3] using final_fe.doc, label ctitle(Month, Year FE) keep(logprice `controlVars')
outreg2 [r4] using final_fe.doc, label ctitle(City, Year FE) keep(logprice `controlVars')
outreg2 [r5] using final_fe.doc, label ctitle(City, Month FE) keep(logprice `controlVars')
outreg2 [r6] using final_fe.doc, label ctitle(City FE) keep(logprice `controlVars')

