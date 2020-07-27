clear 

use mode_data

** get logs of trips, gas prices **

gen pop_dens = tot_pop/area
local controlVars pop_dens youth_pop senior_pop unemp mhinc avg_commute veh0 forborn

gen id = _n
gen timevar = mod(id-1, 156)
drop id
gen panelvar = 1
replace panelvar = 2 if city=="Cleveland"
replace panelvar = 3 if city=="Chicago"
replace panelvar = 4 if city=="Denver"
replace panelvar = 5 if city=="Houston"
replace panelvar = 6 if city=="LA"
replace panelvar = 7 if city=="Miami"
replace panelvar = 8 if city=="NYC"
replace panelvar = 9 if city=="San Francisco"
replace panelvar = 10 if city=="Seattle"
tsset panelvar timevar

gen logtrips = log(trips)
gen logprice = log(gprice)
gen log_stateprice = log(stategas)

**regression 3: month and city fixed effects, no uber, controls**
xi: reg logtrips logprice L1.logprice L2.logprice L3.logprice L4.logprice ///
 L5.logprice L6.logprice L7.logprice L8.logprice L9.logprice L10.logprice L11.logprice L12.logprice ///
 i.city i.month tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
	
xi: reg logtrips logprice L6.logprice L12.logprice `controlVars' i.city i.month

xi: reg logtrips logprice `controlVars' i.city i.month
