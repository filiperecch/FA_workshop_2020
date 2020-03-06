********************************************************************************
********************************************************************************
************** Basic commands - Factor Analysis and PCA ************************
*************************** Workshop 2019 **************************************
********************************************************************************
********************************************************************************

cd "PATH TO YOUR DATA FOLDER"

import delimited "data_all_ctry.csv", clear

destring cs4k1-cs4n12, replace force

foreach v of var * { 
	drop if missing(`v') 
}

sum cs4k1-cs4n12

pwcorr cs4k1-cs4n12

********************************************************************************
********************************************************************************

* Factor analysis - all variables
 
factor cs4k1-cs4n12, pf blanks()

rotate, promax blanks(.3)

scree

* Factor analysis - Section K: School Curriculum
 
factor cs4k1-cs4k7, pf blanks()

rotate, promax blanks(.3)

scree

* Factor analysis - Section N: Classrooms
 
factor cs4n1-cs4n12, pf blanks()

rotate, promax blanks(.3)

scree

********************************************************************************
********************************************************************************

* Ordinal data
* first, standardize the data
//
// findit polychoric /*first time only, need to install pkg*/
//
// foreach var of varlist bio geo chem alg calc stat {
// egen std`var'=std(`var')
// }
//
// polychoric stdbio stdgeo stdchem stdalg stdcalc stdstat
//
// global N = r(sum_w)
// matrix r = r(R)
// factormat r, n($N) 
//
// rotate, varimax blanks(.3)
//
// predict plc1 plc2 
//
//
// ********************************************************************************
// ********************************************************************************
//
// * Binary data - needs binary data!
//
// foreach var of varlist bio geo chem alg calc stat {
// gen dummy`var'= 0
// replace dummy`var' = 1 if `var' >= 4
// }
//
// tetrachoric dummybio dummygeo dummychem dummyalg dummycalc dummystat
//
// matrix C = r(corr)
// matrix symeigen eigenvectors eigenvalues = C
// matrix list eigenvalues
// factormat C, n(300) ipf
//
// rotate, varimax blanks(.3)
//
// predict tc1 tc2

********************************************************************************
********************************************************************************





