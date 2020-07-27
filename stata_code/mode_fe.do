clear

use mode_data

gen logLR = log(lr)
gen logHR = log(hr)
gen logCR = log(cr)
gen logBus = log(bus)
gen logprice = log(gprice)

gen pop_dens = tot_pop/area

reg logBus logprice tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r1

xi: reg logBus logprice i.city i.year i.month tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r2
	
xi: reg logBus logprice i.month i.year tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r3
	
xi: reg logBus logprice i.city i.year tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r4

xi: reg logBus logprice i.city i.month pop_dens youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r5

xi: reg logBus logprice i.city tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r6

outreg2 [r1] using bus_fe.doc, ctitle(No FE)
outreg2 [r2] using bus_fe.doc, ctitle(All FE)
outreg2 [r3] using bus_fe.doc, ctitle(Month, Year FE)
outreg2 [r4] using bus_fe.doc, ctitle(City, Year FE)
outreg2 [r5] using bus_fe.doc, ctitle(City, Month FE)
outreg2 [r6] using bus_fe.doc, ctitle(City FE)

reg logLR logprice tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r1

xi: reg logLR logprice i.city i.year i.month tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r2
	
xi: reg logLR logprice i.month i.year tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r3
	
xi: reg logLR logprice i.city i.year tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r4

xi: reg logLR logprice i.city i.month pop_dens youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r5

xi: reg logLR logprice i.city tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r6

outreg2 [r1] using lightrail_fe.doc, ctitle(No FE)
outreg2 [r2] using lightrail_fe.doc, ctitle(All FE)
outreg2 [r3] using lightrail_fe.doc, ctitle(Month, Year FE)
outreg2 [r4] using lightrail_fe.doc, ctitle(City, Year FE)
outreg2 [r5] using lightrail_fe.doc, ctitle(City, Month FE)
outreg2 [r6] using lightrail_fe.doc, ctitle(City FE)

reg logHR logprice tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r1

xi: reg logHR logprice i.city i.year i.month tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r2
	
xi: reg logHR logprice i.month i.year tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r3
	
xi: reg logHR logprice i.city i.year tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r4

xi: reg logHR logprice i.city i.month tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r5

xi: reg logHR logprice i.city tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r6

outreg2 [r1] using heavyrail_fe.doc, ctitle(No FE)
outreg2 [r2] using heavyrail_fe.doc, ctitle(All FE)
outreg2 [r3] using heavyrail_fe.doc, ctitle(Month, Year FE)
outreg2 [r4] using heavyrail_fe.doc, ctitle(City, Year FE)
outreg2 [r5] using heavyrail_fe.doc, ctitle(City, Month FE)
outreg2 [r6] using heavyrail_fe.doc, ctitle(City FE)

reg logCR logprice tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r1

xi: reg logCR logprice i.city i.year i.month tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r2
	
xi: reg logCR logprice i.month i.year tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r3
	
xi: reg logCR logprice i.city i.year tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r4

xi: reg logCR logprice i.city i.month tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r5

xi: reg logCR logprice i.city tot_pop area youth_pop unemp mhinc senior_pop ///
	avg_commute veh0 forborn
eststo r6

outreg2 [r1] using comrail_fe.doc, ctitle(No FE)
outreg2 [r2] using comrail_fe.doc, ctitle(All FE)
outreg2 [r3] using comrail_fe.doc, ctitle(Month, Year FE)
outreg2 [r4] using comrail_fe.doc, ctitle(City, Year FE)
outreg2 [r5] using comrail_fe.doc, ctitle(City, Month FE)
outreg2 [r6] using comrail_fe.doc, ctitle(City FE)
