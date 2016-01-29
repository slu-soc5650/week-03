// ==========================================================================

// SOC 4650/5650 - LECTURE 03

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
file name - lecture03-code.do

project name -	SOC 4650/5650
                                                                                 
purpose - week 3 replication file
	                                                                               
created - 29 Jan 2016

updated - 29 Jan 2016
                                                                                
author - CHRIS
*/                                                                              

// ==========================================================================
                                                                                 
/* 
full description - 
This file replicates the Stata steps for Lecture 03.
*/

/* 
updates - 
none
*/

// ==========================================================================

/* 
superordinates  - 
This file requires the file census.dta that comes loaded with Stata.
*/

/* 
subordinates - 
none
*/

// ==========================================================================
// ==========================================================================

// using numerical operators
display 2+2

display 2*2

display 20-10

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// using relational operators

sysuse census.dta

summarize pop if pop < 1000000 // population less than 1000000 individuals

summarize pop if region == 1 // population of new england states

list state pop if region == 1 // list of new england states' populations

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// using logical operators

// population of new england states with less than 1000000 individuals
summarize pop if pop < 1000000 & region == 1 

// list of new england states with less than 1000000 individuals
list state pop if pop < 1000000 & region == 1

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// explore the region variable with a frequency table

tabulate region

tabulate region, nolabel // to see the underlying numeric structure

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// create new variables with generate and replace

generate west = . // create empty variable for indicating a west coast state

replace west = 0 if region < 4 // all non-west states represented as 0

replace west = 1 if region == 4 // all west coast states represented as 1

// ==========================================================================
// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit
