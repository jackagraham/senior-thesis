clear

cd "/n/homeserver2/user3a/jag6/Thesis"

use main_data

** pt 1: regression with city fixed effects, level on level

xi: reg trips gprice i.city

** pt 2: regression with city, month fixed effects, level on level

xi: reg trips gprice i.city i.month

** pt 3: regression with city fixed effects, log on level

gen logtrips = log(trips)
xi: reg logtrips gprice i.city

** pt 4: regression with city, month fixed effects, log on level

xi: reg logtrips gprice i.city i.month

** pt 5: regression with city, month fixed effects, log on log

gen logprice = log(gprice)
xi: reg logtrips logprice i.city i.month
