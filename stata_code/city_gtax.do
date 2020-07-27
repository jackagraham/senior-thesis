clear

use city_gtax

gen taxratio = 1+tax/gprice

gen logtrips = log(trips)
gen logprice = log(gprice)
gen logratio = log(taxratio)

xi: reg logtrips logprice logratio i.city i.month i.year tot_pop area youth_pop unemp mhinc ///
	senior_pop avg_commute veh0 forborn
