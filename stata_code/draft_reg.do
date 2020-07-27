clear 

use reg_data

** get logs of trips, gas prices

gen logtrips = log(trips)
gen logprice = log(gprice)
gen log_stateprice = log(stategas)


local controlVars tot_pop area youth_pop senior_pop unemp mhinc avg_commute veh0 forborn

**regression 1: no fixed effects, no uber, no controls**
reg logtrips logprice, r
outreg2 using reg1.doc, replace

**regression 2: no fixed effects, no uber, controls**
reg logtrips logprice `controlVars', r
eststo r2

**regression 3: month and city fixed effects, no uber, controls**
xi: reg logtrips logprice i.city i.month i.year `controlVars', vce(cluster city)
eststo r3

gen no_uber_price = logprice*no_uber
gen uber_price = logprice*uber

**regression 4: fixed effects, uber, controls**
xi: reg logtrips no_uber_price uber_price i.city i.month i.year `controlVars', vce(cluster city)
eststo r4

**regression 5: no fixed effects, uber, controls**
xi: reg logtrips no_uber_price uber_price `controlVars', vce(cluster city)
eststo r5

outreg2 [r2] using main_uber.doc, ctitle(No FE, No Uber)
outreg2 [r3] using main_uber.doc, ctitle(FE, No Uber) 
outreg2 [r5] using main_uber.doc, ctitle(No FE, Uber) 
outreg2 [r4] using main_uber.doc, ctitle(FE, Uber) 

**IV first stage regression**
reg log_stateprice logprice 

**regression 6: IV, no fixed effects, no uber, controls**
reg logtrips log_stateprice `controlVars'
eststo r6

gen state_no_uber_price = log_stateprice*no_uber
gen state_uber_price = log_stateprice*uber

**regression 7: IV, fixed effects, no uber, controls**
xi: reg logtrips log_stateprice i.city i.month i.year `controlVars', vce(cluster city)
eststo r7

**regression 8: IV, no fixed effects, uber, controls
reg logtrips state_no_uber_price state_uber_price `controlVars'
eststo r8
	
**regression 9: IV, fixed effects, uber, controls
xi: reg logtrips state_no_uber_price state_uber_price i.city i.month i.year ///
        `controlVars', vce(cluster city)	
eststo r9

outreg2 [r6] using iv_reg.doc, ctitle(No FE, No Uber)
outreg2 [r7] using iv_reg.doc, ctitle(FE, No Uber)
outreg2 [r8] using iv_reg.doc, ctitle(No FE, Uber)
outreg2 [r9] using iv_reg.doc, ctitle(FE, Uber)





