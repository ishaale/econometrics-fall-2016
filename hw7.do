capture log close
cd "Client\C$\Users\Elisha Ishaal\Documents\Fall 2016\Econometrics"

clear all
macro drop_all

local filename "hw7"

log using hw7, replace text

/*hw7.do
Elisha Ishaal, 12Nov16*/

version 14

set more off
set linesize 80

sysuse SMOKE
summarize, separator(0)

global model "cigs lincome lcigpric educ age agesq restaurn"
reg $model

predict res, residuals
generate res_sq = res^2
label variable res_sq "residuals squared"

reg res_sq lincome lcigpric educ age agesq restaurn
avplots, name (avplot)

test (lincome = 0) (lcigpric = 0)(educ = 0)(age = 0)(agesq = 0)(restaurn = 0)

generate cigs_sq = cigs^2
label variable cigs_sq "square of cigs smoked"

reg res_sq cigs cigs_sq
avplots, name (avplot1)

test (cigs = 0)(cigs_sq = 0)

reg cigs lincome lcigpric educ age agesq restaurn, robust

generate lres_sq = log(res_sq)
label variable lres_sq "log of squared residuals"

reg lres_sq lincome lcigpric educ age agesq restaurn
predict fitted

generate exp_fitted = exp(fitted)
label variable exp_fitted "exponential of fitted values"

generate sd = sqrt(exp_fitted)
label variable sd "sqrt of exp_fitted"
vwls $model , sd(sd) 

generate adj_cigs = cigs / sd
label variable adj_cigs "adjusted cigs"
generate adj_lincome = lincome / sd
label variable adj_lincome "adjusted lincome"
generate adj_lcigpric = lcigpric / sd
label variable adj_lcigpric "adjested lcigpric"
generate adj_educ = educ / sd
label variable adj_educ "adjusted educ"
generate adj_age = age / sd
label variable adj_age "adjusted age"
generate adj_agesq = agesq / sd
label variable adj_agesq "adjusted agesq"
generate adj_restaurn = restaurn / sd
label variable adj_restaurn "adjusted restaurn"

generate inverse_sd = 1 / sd
label variable inverse_sd "inverse sd"

reg adj_cigs adj_lincome adj_lcigpric adj_educ adj_age adj_agesq adj_restaurn inverse_sd, noconstant

save hw7, replace
log close
exit
