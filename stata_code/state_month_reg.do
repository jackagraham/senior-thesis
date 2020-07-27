clear 

import delimited "state_month_controls.csv"

gen logtrips = log(trips)
gen logprice = log(gprice)

destring totalpopulation medianhouseholdincome, gen (tot_pop mhinc) ignore(",")
gen senior_pop = 1-lessthan55years
rename lessthan18years youth_pop
rename averagecommutetoworkinmin avg_commute
rename publictransportationincludestaxi took_transit
drop totalpopulation medianhouseholdincome lessthan55years
rename areatotal area
rename foreignborn forborn

label variable logprice "log(Gas Price)"
label variable logtrips "log(UPT)"
label variable youth_pop "Population under 18"
label variable senior_pop "Population over 55"
label variable forborn "Foreign-born Population"
label variable unemp "Unemployment Rate"

save state_month_controls, replace

local controlVars tot_pop youth_pop senior_pop unemp mhinc avg_commute forborn

gen id = _n
gen month_id = mod(id-1, 12)
drop id

gen POST = year>=2009 | (year==2008 & month_id>=9)
gen POST_TREAT = (state=="MN" & POST)
keep if (year<=2013)
gen TREAT = state=="MN"

reg logtrips POST TREAT POST_TREAT `controlVars' 

xi: reg logtrips logprice `controlVars' i.state i.month_id

reg logtrips logprice POST TREAT POST_TREAT `controlVars' i.month_id

xi:reg logtrips POST POST_TREAT `controlVars' i.state

xi:reg logtrips logprice POST POST_TREAT `controlVars' i.state i.month_id i.year
outreg2 using finalMinnDiD.doc, replace label keep(logprice POST POST_TREAT `controlVars')

