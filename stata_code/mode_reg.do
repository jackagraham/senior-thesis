clear

use mode_data

gen logLR = log(lr)
gen logHR = log(hr)
gen logCR = log(cr)
gen logBus = log(bus)
gen logprice = log(gprice)

**Various modes : month and city fixed effects, no uber, controls**
xi: reg logLR logprice i.city i.month i.year tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn, vce(cluster city)
eststo r1
	
xi: reg logHR logprice i.city i.month i.year tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn, vce(cluster city)
eststo r2
	
xi: reg logCR logprice i.city i.month i.year tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn, vce(cluster city)
eststo r3

xi: reg logBus logprice i.city i.month i.year tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn, vce(cluster city)
eststo r4
	
outreg2 [r1] using mode_noUber.doc, ctitle(Light Rail)
outreg2 [r2] using mode_noUber.doc, ctitle(Heavy Rail) 
outreg2 [r3] using mode_noUber.doc, ctitle(Commuter Rail) 
outreg2 [r4] using mode_noUber.doc, ctitle(Bus)
	
gen no_uber_price = logprice*no_uber
gen uber_price = logprice*uber

**Various modes: fixed effects, uber, controls**
xi: reg logLR no_uber_price uber_price i.city i.month i.year ///
	tot_pop area youth_pop senior_pop unemp mhinc avg_commute veh0 forborn, ///
	vce(cluster city)
eststo r5
	
xi: reg logHR no_uber_price uber_price i.city i.month i.year ///
	tot_pop area youth_pop senior_pop unemp mhinc avg_commute veh0 forborn, ///
	vce(cluster city)
eststo r6
	
xi: reg logCR no_uber_price uber_price i.city i.month i.year ///
	tot_pop area youth_pop senior_pop unemp mhinc avg_commute veh0 forborn, ///
	vce(cluster city)
eststo r7

xi: reg logBus no_uber_price uber_price i.city i.month i.year ///
	tot_pop area youth_pop senior_pop unemp mhinc avg_commute veh0 forborn, ///
	vce(cluster city)
eststo r8
	
outreg2 [r5] using mode_uber.doc, ctitle(Light Rail)
outreg2 [r6] using mode_uber.doc, ctitle(Heavy Rail) 
outreg2 [r7] using mode_uber.doc, ctitle(Commuter Rail) 
outreg2 [r8] using mode_uber.doc, ctitle(Bus)
