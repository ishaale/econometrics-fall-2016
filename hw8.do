capture log close
cd "Client\C$\Users\Elisha Ishaal\Documents\Fall 2016\Econometrics"

clear all
macro drop_all

local filename "hw8"

log using hw8, replace text

/*hw8.do
Elisha Ishaal, 2Dec16*/

version 14

set more off
set linesize 80

sysuse cps91

generate huswage = husearns/hushrs
label variable huswage "hourly husband wage"
generate lhuswage = log(huswage)
label variable lhuswage "log of husband's hourly wage"
generate husexpsq = husexp^2
label variable husexpsq "square of husband's experience"
global model "lhuswage huseduc husexp husexpsq"
reg $model

predict fitted
generate fittedsq = fitted^2
label variable fittedsq "square of expected values"
generate fittedcb = fitted^3
label variable fittedcb "cube of expected values"
reg $model fittedsq fittedcb
test (fittedsq = 0) (fittedcb = 0)

generate huseducsq = huseduc^2
label variable huseducsq "huseduc^2"
generate husexpcb = husexp^3
label variable husexpcb "husexp^3"
generate huseducexp = huseduc*husexp
label variable huseducexp "interaction between education and experience"
reg $model huseducexp huseducsq husexpcb

predict fitted2
generate fitted2 = fitted2^2
label variable fitted2 "new fittedsq"
generate fitted3 = fitted2^3
label variable fitted3 "new fittedcb"
reg $model huseducexp huseducsq husexpcb fitted2 fitted3
test (fitted2 = 0) (fitted3 = 0)


sysuse CRIME2
global model2 "lcrmrte unem llawexpc"
reg $model2

drop if mi(lcrmrt_1)
reg $model2

reg $model2 lcrmrt_1

reg clcrmrte cunem cllawexp
rvfplot

sysuse 401KSUBSM
global model3 "nettfa inc age male e401k"
reg $model3
reg nettfa inc_m age male e401k

reg inc_m age male e401k
predict fitted3

generate Inc_m = inc_m
replace Inc_m = fitted3 if mi(Inc_m)
label variable Inc_m "inc_m with filled in values"
reg nettfa Inc_m age male e401k

save hw8, replace
log close
exit
