clear

use reg_data

gen logtrips = log(trips)
gen logprice = log(gprice)
gen log_stateprice = log(stategas)
gen no_uber_price = logprice*no_uber
gen uber_price = logprice*uber

label variable no_uber_price "Pre-Uber"
label variable uber_price "Post-Uber"

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

keep logtrips logprice pop_dens youth_pop senior_pop unemp mhinc avg_commute veh0 forborn

asdoc sum, replace label dec(2)

