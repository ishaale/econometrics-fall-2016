capture log close
cd "Client\C$\Users\Elisha Ishaal\Documents\Fall 2016\Econometrics"

clear all
macro drop_all

local filename "hw5"

log using hw5, replace text

/*hw5.do
Elisha Ishaal, 26Oct16*/

version 14

set more off
set linesize 80

sysuse MLB1
summarize, separator(0)

global model "lsalary years gamesyr bavg hrunsyr rbisyr"
reg $model

test (bavg = 0)(hrunsyr = 0)(rbisyr = 0)

reg bavg hrunsyr rbisyr
reg hrunsyr bavg rbisyr
reg rbisyr bavg hrunsyr

reg lsalary years gamesyr bavg hrunsyr

reg $model
avplots, name(avplot)
rvfplot, yline(0) name (rvfplot)

generate bavg_sub = bavg if (bavg <= 500)
label variable bavg_sub "bavg less than 500"

reg lsalary years gamesyr bavg_sub hrunsyr rbisyr

generate sq_yrs = years^2
label variable sq_yrs "square of years"

reg $model sq_yrs

predict residuals, resid
di residuals[18]

save hw5, replace
log close
exit
