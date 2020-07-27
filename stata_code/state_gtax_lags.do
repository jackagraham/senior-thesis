clear

use state_gtax_lag

gen taxratio = 1+gtax/gprice
gen loggprice = log(gprice-gtax)
gen logtax = log(gtax)
gen trips = hr + lr + cr + bus
gen logtrips = log(trips)
gen logprice = log(gprice)
gen logratio = log(taxratio)

gen id = _n
gen timevar = mod(id-1, 12)
drop id

tsset panelvar timevar

xi: reg logtrips L1.logtrips logprice L1.logtax i.state 