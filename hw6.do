capture log close
cd "Client\C$\Users\Elisha Ishaal\Documents\Fall 2016\Econometrics"

clear all
macro drop_all

local filename "hw6"

log using hw6, replace text

/*hw6.do
Elisha Ishaal, 05Nov16*/

version 14

set more off
set linesize 80

sysuse MLB1

generate bavg_sub = bavg if (bavg <= 500)
label variable bavg_sub "bavg less than 500"

global model "lsalary years gamesyr bavg_sub rbisyr"

reg $model

global positions "frstbase scndbase shrtstop thrdbase outfield"

reg $model $positions

test (frstbase = 0)(scndbase = 0)(shrtstop = 0)(thrdbase = 0)(outfield = 0)

test (frstbase = scndbase)

reg $model $positions catcher

generate years_sq = years^2
label variable years_sq "square of years"

generate int1 = catcher*years
label variable int1 "catcher*years"
generate int2 = catcher*years_sq
label variable int2 "catcher*years_sq"
generate int3 = (1-catcher)*years
label variable int3 "not the catcher"
generate int4 = (1-catcher)*years_sq
label variable int4 "not the catcher"

reg lsalary int1 int2 int3 int4 gamesyr bavg_sub rbisyr frstbase scndbase shrtstop thrdbase outfield

test (catcher < frstbase) (catcher < scndbase) (catcher < shrtstop) (catcher < thrdbase) (catcher < outfield) 

reg $model $positions hispan black

reg $model $positions blckpb hispph

save hw6, replace
log close
exit
