capture log close
cd "Client\C$\Users\Elisha Ishaal\Documents\Fall 2016\Econometrics"

clear all
macro drop_all

local filename "hw9"

log using hw9, replace text

/*hw9.do
Elisha Ishaal, 2Dec16*/

version 14

set more off
set linesize 80

sysuse WAGE2
summarize lwage educ exper tenure married black IQ sibs

global model "lwage educ exper tenure married black"
reg $model

reg $model IQ

reg educ exper tenure married black IQ sibs brthord
test(sibs = 0)(brthord = 0)

ivregress 2sls lwage (educ = sibs brthord) exper tenure married black

reg $model
predict res, residuals
correlate res educ
reg educ res

ivregress 2sls lwage (educ = sibs brthord) exper tenure married black
estat overid

save hw9, replace
log close
exit
