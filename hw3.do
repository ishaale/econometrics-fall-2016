capture log close
cd "Client\C$\Users\Elisha Ishaal\Documents\Fall 2016\Econometrics"

clear all
macro drop_all

local filename "hw3"

log using hw3, replace text

/*hw3.do
Elisha Ishaal, 13Oct16*/

version 14

set more off
set linesize 80

infile salary age college grad comten ceoten sales profits mktval lsalary lsales lmktval comtensq ceotensq profmarg using CEOSAL2

label variable salary "1990 compensation, $1000s"
label variable age "in years"
label variable college "=1 if attended college"
label variable grad "=1 if attended graduate school"
label variable comten "years with company"
label variable ceoten "years as ceo with company"
label variable sales "1990 firm sales, millions"
label variable profits "1990 profits, millions"
label variable mktval "market value, end 1990, mills."
label variable lsalary "log(salary)"
label variable lsales "log(sales)"
label variable lmktval "log(mktval)"
label variable comtensq "comten^2"
label variable ceotensq "ceoten^2"
label variable profmarg "profits as % of sales"

summarize, detail

global model_base "lsalary lsales lmktval"
reg $model_base

avplots, name(reg_plot)

reg lsales lmktval
predict res_lsales, residuals
reg lsalary res_lsales

reg $model_base ceoten

reg $model_base ceoten ceotensq
avplots, name (ceoten_plot)

reg $model_base ceoten ceotensq college grad

save hw3, replace
log close
exit
