capture log close
cd "Client\C$\Users\Elisha Ishaal\Documents\Fall 2016\Econometrics"

clear all
macro drop_all

local filename "hw10"

log using hw10, replace text

/*hw9.do
Elisha Ishaal, 9Dec16*/

version 14

set more off
set linesize 80

sysuse BARIUM

tsset t

global model "lchnimp lchempi lgas lrtwex befile6 affile6 afdec6"
summarize $model, separator(0)
reg $model

global model2 "lchnimp lchempi lrtwex afdec6"
reg $model2

global model3 "t lchnimp lchempi lgas lrtwex"
reg $model3
avplots, name(avplot)

estat archlm
predict res, residuals
//regress residuas of t against residuals of t-1
//test with null (coefficient = 0)

reg t lchempi
reg t lrtwex
reg t lchnimp

gen trend = _n
label variable trend "time trend"
reg $model3 trend

save hw10, replace
log close
exit
