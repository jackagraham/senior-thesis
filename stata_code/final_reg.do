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

egen city_id=group(city)
egen year_id=group(year)

**baseline reg**
reg logtrips logprice i.city_id i.month `controlVars'
outreg2 using finalBase.doc, replace label keep(logprice `controlVars')

**baseline reg with state IV**
reg logtrips log_stateprice i.city_id i.month `controlVars'
outreg2 using finalIV.doc, replace label keep(log_stateprice `controlVars')

** Uber reg with all years (for appendix)
reg logtrips no_uber_price uber_price i.city_id i.month `controlVars'
outreg2 using finalAppUber.doc, replace label keep(no_uber_price uber_price `controlVars')

keep if year>=2010 & year <=2014
**Uber reg**
reg logtrips no_uber_price uber_price i.city_id i.month i.year_id `controlVars'
outreg2 using finalUber.doc, replace label keep(no_uber_price uber_price `controlVars')

clear

use mode_data

gen logLR = log(lr)
gen logHR = log(hr)
gen logCR = log(cr)
gen logBus = log(bus)
gen logprice = log(gprice)
gen logstateprice = log(stategas)

label variable logprice "log(Gas Price)"

gen pop_dens = tot_pop/area
label variable pop_dens "Population Density"
label variable veh0 "No Vehicle HH"
label variable youth_pop "Population under 18"
label variable senior_pop "Population over 55"
label variable forborn "Foreign-born Population"
label variable unemp "Unemployment Rate"
label variable stategas "log(State Gas Price)"

local controlVars pop_dens youth_pop senior_pop unemp mhinc avg_commute veh0 forborn

egen city_id=group(city)
egen year_id=group(year)

**baseline reg with modes
reg logBus logprice i.city_id i.month `controlVars'
eststo r1
reg logLR logprice i.city_id i.month `controlVars'
eststo r2
reg logCR logprice i.city_id i.month `controlVars'
eststo r3
reg logHR logprice i.city_id i.month `controlVars'
eststo r4

outreg2 [r2] using finalModes.doc, replace label keep(logprice `controlVars') ctitle(Light Rail)
outreg2 [r4] using finalModes.doc, label keep(logprice `controlVars') ctitle(Heavy Rail) 
outreg2 [r3] using finalModes.doc, label keep(logprice `controlVars') ctitle(Commuter Rail) 
outreg2 [r1] using finalModes.doc, label keep(logprice `controlVars') ctitle(Bus)

**baseline reg with modes
reg logBus logstateprice i.city_id i.month `controlVars'
eststo r5
reg logLR logstateprice i.city_id i.month `controlVars'
eststo r6
reg logCR logstateprice i.city_id i.month `controlVars'
eststo r7
reg logHR logstateprice i.city_id i.month `controlVars'
eststo r8

outreg2 [r6] using finalIVModes.doc, replace label keep(logstateprice `controlVars') ctitle(Light Rail)
outreg2 [r8] using finalIVModes.doc, label keep(logstateprice `controlVars') ctitle(Heavy Rail) 
outreg2 [r7] using finalIVModes.doc, label keep(logstateprice `controlVars') ctitle(Commuter Rail) 
outreg2 [r5] using finalIVModes.doc, label keep(logstateprice `controlVars') ctitle(Bus)


clear 

use mode_data

** get logs of trips, gas prices **

gen logtrips = log(trips)
gen logprice = log(gprice)
gen log_stateprice = log(stategas)

label variable logprice "log(Gas Price)"

gen pop_dens = tot_pop/area
label variable pop_dens "Population Density"
label variable veh0 "No Vehicle HH"
label variable youth_pop "Population under 18"
label variable senior_pop "Population over 55"
label variable forborn "Foreign-born Population"
label variable unemp "Unemployment Rate"

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

egen city_id=group(city)

** reg with lags **
reg logtrips logprice L6.logprice L12.logprice `controlVars' i.panelvar i.month
outreg2 using finalLags.doc, replace label keep(logprice L6.logprice L12.logprice `controlVars')

gen logLR = log(lr)
gen logHR = log(hr)
gen logCR = log(cr)
gen logBus = log(bus)

** reg wit lags and modes **
reg logLR logprice L6.logprice L12.logprice `controlVars' i.panelvar i.month
eststo r5
reg logHR logprice L6.logprice L12.logprice `controlVars' i.panelvar i.month
eststo r6
reg logCR logprice L6.logprice L12.logprice `controlVars' i.panelvar i.month
eststo r7
reg logBus logprice L6.logprice L12.logprice `controlVars' i.panelvar i.month
eststo r8

outreg2 [r5] using finalModesLags.doc, label keep(logprice L6.logprice L12.logprice `controlVars') ctitle(Light Rail)
outreg2 [r6] using finalModesLags.doc, label keep(logprice L6.logprice L12.logprice `controlVars') ctitle(Heavy Rail) 
outreg2 [r7] using finalModesLags.doc, label keep(logprice L6.logprice L12.logprice `controlVars') ctitle(Commuter Rail) 
outreg2 [r8] using finalModesLags.doc, label keep(logprice L6.logprice L12.logprice `controlVars') ctitle(Bus)






