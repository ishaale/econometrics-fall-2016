capture log close
cd "Client\C$\Users\Elisha Ishaal\Documents\Fall 2016\Econometrics"

clear all
macro drop_all

local filename "hw2"

log using hw2, replace text

/*hw2.do
Elisha Ishaal, 29Sep16*/

version 14

set more off
set linesize 80

sysuse 401k

twoway (scatter prate mrate) (lfit prate mrate), name(scatter_prate_mrate)
reg prate mrate

predict fitted
summarize fitted, detail

predict resid, resdiuals
generate sqresid = resid^2
label variable sqresid	"squared residuals"

twoway scatter sqresid mrate, name(scatter_sqresid_mrate)

generate mrate_sub = mrate if mrate <= 1
label variable mrate_sub "mrate if mrate <= 1"

reg prate mrate_sub
twoway (scatter prate mrate_sub) (lfit prate mrate_sub), name (prate_mrate_sub)

predict residuals_sub, residuals
generate sqresid_sub = residuals_sub^2
label variable sqresid_sub "new squared resdiuals"
twoway scatter sqresid_sub mrate_sub

test (mrate_sub = 20)

generate log_mrate = log(mrate)
label variable log_mrate "log of mrate"
generate log_prate = log(prate)
label variable log_prate "log of prate"

reg log_prate log_mrate

save hw2, replace
log close
exit
