clear

import delimited "state_month_mode_controls.csv"

gen loghr = log(hr)
gen loglr = log(lr)
gen logcr = log(cr)
gen logbus = log(bus)
gen logprice = log(gprice)

destring totalpopulation medianhouseholdincome, gen (tot_pop mhinc) ignore(",")
gen senior_pop = 1-lessthan55years
rename lessthan18years youth_pop
rename averagecommutetoworkinmin avg_commute
rename publictransportationincludestaxi took_transit
drop totalpopulation medianhouseholdincome lessthan55years
rename areatotal area
rename foreignborn forborn

save state_month_mode_controls, replace

local controlVars tot_pop youth_pop senior_pop unemp mhinc avg_commute forborn

gen id = _n
gen month_id = mod(id-1, 12)
drop id

gen POST = year>=2009 | (year==2008 & month_id>=9)
gen POST_TREAT = (state=="MN" & POST)
keep if (year<=2013)
gen TREAT = state=="MN"

xi:reg loghr logprice POST POST_TREAT `controlVars' i.state i.month_id
xi:reg loglr logprice POST POST_TREAT `controlVars' i.state i.month_id
xi:reg logcr logprice POST POST_TREAT `controlVars' i.state i.month_id
xi:reg logbus logprice POST POST_TREAT `controlVars' i.state i.month_id




