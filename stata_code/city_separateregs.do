clear

use reg_data

** get logs of trips, gas prices

gen logtrips = log(trips)
gen logprice = log(gprice)
gen log_stateprice = log(stategas)

local controlVars tot_pop area youth_pop senior_pop unemp mhinc avg_commute veh0 forborn

preserve 

keep if city=="Boston"

reg logtrips logprice `controlVars', r

restore 

preserve

keep if city=="Chicago"

reg logtrips logprice `controlVars', r

restore 

preserve

keep if city=="Cleveland"

reg logtrips logprice `controlVars', r

restore 

preserve

keep if city=="Denver"

reg logtrips logprice `controlVars', r

restore 

preserve

keep if city=="Houston"

reg logtrips logprice `controlVars', r

restore 

preserve

keep if city=="LA"

reg logtrips logprice `controlVars', r

restore 

preserve

keep if city=="Miami"

reg logtrips logprice `controlVars', r

restore 

preserve

keep if city=="NYC"

reg logtrips logprice `controlVars', r

restore 

preserve

keep if city=="San Francisco"

reg logtrips logprice `controlVars', r

restore 

preserve

keep if city=="Seattle"

reg logtrips logprice `controlVars', r

restore 

