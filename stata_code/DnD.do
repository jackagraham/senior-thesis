clear 

use reg_data

drop if (year >= 2013)

gen logtrips = log(trips)
gen logprice = log(gprice)
gen log_stateprice = log(stategas)
gen POST_TREAT = (year >= 2010 & (city== "LA" | city == "San Francisco"))

local controlVars tot_pop area youth_pop senior_pop unemp mhinc avg_commute veh0 forborn

xi: reg logtrips POST_TREAT `controlVars' i.city i.month

xi: reg logtrips logprice POST_TREAT `controlVars' i.city i.month i.year

