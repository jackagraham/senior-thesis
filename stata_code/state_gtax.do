clear

use reg_data_states

gen taxratio = 1+gtax/gprice
gen loggprice = log(gprice-gtax)
gen logtax = log(gtax)
gen trips = hr + lr + cr + bus
gen logtrips = log(trips)
gen logprice = log(gprice)
gen logratio = log(taxratio)
rename areatotal area
rename foreignborn forborn

label variable loggprice "log(Gas Price)"
label variable logtrips "log(UPT)"
label variable youth_pop "Population under 18"
label variable senior_pop "Population over 55"
label variable forborn "Foreign-born Population"
label variable unemp "Unemployment Rate"
label variable logratio "Tax Ratio"
label variable logtax "log(Gas Tax)"

local controlVars tot_pop youth_pop senior_pop unemp mhinc avg_commute forborn

xi: reg logtrips logprice logratio `controlVars' i.state i.year

xi: reg logtrips loggprice logratio `controlVars' i.state
eststo r1

xi: reg logtrips loggprice logtax `controlVars' i.state
eststo r2

outreg2 [r1] using finalStateGtax.doc, label keep(loggprice logratio `controlVars') ctitle('Tax Ratio')
outreg2 [r2] using finalStateGtax.doc, label keep(loggprice logtax `controlVars') ctitle('State Gas Tax')