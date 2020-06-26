capture log close
cd "Client\C$\Users\Elisha Ishaal\Documents\Fall 2016\Econometrics"

clear all
macro drop_all

local filename "hw4"

log using hw4, replace text

/*hw4.do:
Elisha Ishaal 21Oct2016*/

version 14

set more off
set linesize 80

infile price assess bdrms lotsize sqrft colonial lprice lassess llotsize lsqrft using hprice1

label variable price "house price, $1000s"
label variable assess "assessed value, $1000s"
label variable bdrms "number of bedrooms"
label variable lotsize "size of lot in square feet"
label variable sqrft "size of house in square feet"
label variable colonial "=1 if home is colonial style"
label variable lprice "log(price)"
label variable lassess "log(assess)"
label variable llotsize "log(lotsize)"
label variable lsqrft "log(sqrft)"

summarize, detail

global model "price bdrms sqrft lotsize"

reg $model
avplots, name(avplot)
rvfplot, yline(0) name (rvfplot)

generate sqrft_sq = sqrft^2
label variable sqrft_sq "square og house size"
generate lotsize_sq = lotsize^2
label variable lotsize_sq "square of lot size"

reg $model sqrft_sq lotsize_sq

test (sqrft_sq = 0)(lotsize_sq = 0)

reg price assess

test(assess = 1)

reg $model assess

test (bdrm = 0) (sqrft = 0) (lotsize = 0)

save hw4
log close
exit
