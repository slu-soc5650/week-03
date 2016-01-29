// ==========================================================================

// SOC 4650/5650 - LAB 03

// ==========================================================================

// standard opening options

version 14
log close _all
graph drop _all
clear all
set more off
set linesize 80


// ==========================================================================

/* 
file name - lab03-code.do

project name -	SOC 4650/5650
                                                                                 
purpose - lab 03 replication file
	                                                                               
created - 29 Jan 2016

updated - 29 Jan 2016
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 
This file replicates the relevant sections of Mitchell (2010) in Chapter 3
*/

/* 
updates - 
none
*/

// ==========================================================================

/* 
superordinates  - 
- survey1.dta
- survey2.dta
- wws.dta
*/

/* 
subordinates - 
none
*/

// ==========================================================================
// ==========================================================================

cd "/Users/prenercg/Documents/Active"

// ==========================================================================
// ==========================================================================

// SECTION 3.2

// ==========================================================================

// note subtle differences in my approach to this part of lab 03

clear
use survey1.dta 
sort id // note difference from text
save survey1new.dta, replace

clear
use survey2.dta
sort id
save survey2new.dta, replace

// note my use of full filenames including extension for purposes of clarity
// also note my separation of the clear command from the use command
// finally, note that I save copies of all data before using them

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clear
use survey1new.dta
cf id using survey2new.dta, verbose

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clear
use survey1new.dta
cf _all using survey2new.dta, all verbose

// ==========================================================================
// ==========================================================================

// SECTION 3.3

// ==========================================================================

use wws.dta
save wwsNew.dta, replace

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

describe

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

tabulate collgrad, missing

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

tabulate race, missing
list idcode race if race == 4

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

summarize unempins
summarize wage
summarize wage, detail
list idcode wage if wage > 100000

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

summarize age
tabulate age if age >= 45
list idcode age if age > 50

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clear

// ==========================================================================
// ==========================================================================

// SECTION 3.4

// ==========================================================================

use wwsNew.dta

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

tabulate metro ccity, missing
count if metro == 0 & ccity == 1

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

tabulate married nevermarried
count if married == 1 & nevermarried == 1
list idcode married nevermarried if married == 1 & nevermarried == 1, abb(20)

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

table collgrad yrschool

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clear

// ==========================================================================
// ==========================================================================

// SECTION 3.5

// ==========================================================================

use wwsNew.dta

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

summarize uniondues if union == 0

bysort union: summarize uniondues

tabstat uniondues, by(union) statistics(n mean sd min max) missing

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// recode uniondues (0=0) (1/max=1), generate(paysdues)
// an alternate approach using only generate and replace:

generate paysdues = .
replace paysdues = 0 if uniondues == 0
replace paysdues = 1 if uniondues >= 1 & uniondues < .

/* this is longer code, but it is easier to read and implement because
it takes things one step at a time. for learning Stata, this type of
code is easier to read and write. */

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

tabulate union paysdues, missing

list idcode union uniondues if union == 0 & (uniondues > 0) & ! missing(uniondues), abb(20)

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

tabstat marriedyrs, by(married) statistics(n mean sd min max) missing

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

tabstat currexp, by(everworked) statistics(n mean sd min max) missing

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

tabstat prevexp, by(everworked) statistics(n mean sd min max) missing

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

generate totexp = currexp + prevexp

tabstat totexp, by(everworked) statistics(n mean sd min max) missing

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

save wwsNew.dta, replace

clear

// ==========================================================================
// ==========================================================================

// SECTION 3.6

// ==========================================================================

use wwsNew.dta

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

summarize unempins if hours > 30 & ! missing(hours)

count if (hours > 30) & ! missing(hours) & (unempins > 0) & ! missing(unempins)

list idcode hours unempins if (hours > 30) & ! missing(hours) & (unempins > 0) & ! missing(unempins)

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

generate agewhenmarried = age - marriedyrs

tabulate agewhenmarried if agewhenmarried < 18
// note how I do not abbreviate the tabulate command as Mitchell does

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

generate agewhenstartwork = age - (prevexp + currexp)

tabulate agewhenstartwork if agewhenstartwork < 18

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

table kidage2 kidage3 if numkids == 3

count if (kidage3 > kidage2) & (numkids == 3) & ! missing(kidage3)

count if (kidage2 > kidage1) & (numkids >= 2) & ! missing(kidage2)

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

generate agewhenfirstkid = age - kidage1

tabulate agewhenfirstkid if agewhenfirstkid < 18

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clear

// ==========================================================================
// ==========================================================================

// SECTION 3.7

// ==========================================================================

use wwsNew.dta

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

list idcode age yrschool race wage if race == 4

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

list idcode age yrschool race wage if wage > 50

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

table collgrad yrschool

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

list idcode collgrad yrschool if yrschool == 8 & collgrad == 1

list idcode collgrad yrschool if inlist(yrschool,13,14,15) & collgrad

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

replace race = 1 if idcode == 543

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

replace collgrad = 0 if idcode == 107

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

table collgrad yrschool

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

list idcode age if age > 50

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

replace age = 38 if idcode == 51

replace age = 45 if idcode == 80

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

list idcode age if age > 50

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

clear

// ==========================================================================
// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit
