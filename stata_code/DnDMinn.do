clear 

use state_gtax

gen trips = hr + lr + cr + bus
gen logtrips = log(trips)
gen logprice = log(gprice)

gen POST_TREAT = (year>="2009" & state=="MN")
keep if (year<="2012")
gen POST = year>="2009"
gen TREAT = state=="MN"

xi: reg logtrips POST TREAT POST_TREAT

preserve

keep if (state=="SD" | state=="MN" | state=="WI" | state=="ND" | state=="IA")

xi: reg logtrips POST TREAT POST_TREAT
xi: reg logtrips logprice POST_TREAT 

