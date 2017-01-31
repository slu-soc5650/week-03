// ==========================================================================

// Lecture-03 Example Code

// ==========================================================================

// define project name

local projName "stlSchools03"

// ==========================================================================

// standard opening options

log close _all
graph drop _all
clear all
set more off
set linesize 80

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// construct directory structure for tabular data

capture mkdir "CodeArchive"
capture mkdir "DataClean"
capture mkdir "DataRaw"
capture mkdir "LogFile"
capture mkdir "Output"

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

// create permanent text-based log file
log using "LogFile/`projName'.txt", replace text name(permLog)

// create temporary smcl log file for MarkDoc
quietly log using "LogFile/`projName'.smcl", replace smcl name(tempLog)

// ==========================================================================
// ==========================================================================
// ==========================================================================

/***
# Data Cleaning Commands
#### SOC 4650/5650: Intro to GIS
#### Kyle Miller
#### 31 January 2017

### Description
This do-file introduces the basic data cleaning commands for data analysis.

### Dependencies
This do-file was written and executed using Stata 14.2.

It also uses the latest [MarkDoc](https://github.com/haghish/markdoc/wiki)
package via GitHub as well as the latest versions of its dependencies:
***/

version 14
which markdoc
which weave
which statax

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/***
### Import/Open Data
***/

dir

/*** 
The dir command provides the number of file names in the directory as well 
as their names. 
***/

local rawData "STL_EDU_Private.csv"

import delimited `rawData', varnames(1)

describe

/***
The three commands above are from week 02. Check last week's repository
for replication files.
***/

rename address1 address

/***
 The `rename` command is used to change the names of variables. It is helpful 
when one seeks to clean up variable names to make them easily understood. 
Note that while the rename command changes the names of the variable, it 
does not change the variable label or the contents of the variable. 
***/
	
list code facility zip in 1/5 
	
isid code

/***
The `isid` command looks within the specified variable for unique 
identifiers. The variable code would be considered a unique identifier 
because no two observations have the same code number. In the previous 
example, the variable `zip` would produce an error because there are 
multiple observations which share the same zip code. 
***/
		
tabulate zip, missing

/*** 
While using the `tabulate` command provides a list of all zip codes and 
their frequencies, the added option missing exposes any observations for 
which there is no specified zip code. Most often missing observations 
will have a `.` in the `zip` variable. If there is no change in the 
output of the tabulate command with missing, then there are no missing 
observations. 
***/
	
replace zip = "63108" if zip == "63108-2701"

/*** 
The `replace` command is used to make changes in the data set. Here, the 
the line could be read "for all observations, replace the variable  
`zip` with `63108` if the observation is `63108-2701` in the zip variable." 
Notice the differences in the equal signs. Also notice, the 
output has the number of observations that were changed as a result of 
this line of code. 
***/
	
replace zip = "63113" if zip == "63113-2942"
replace zip = "63115" if zip == "63115-1238"			
replace zip = "63139" if zip == "63139-1906"

/***

***/

tabulate zip, missing

/***

***/

duplicates report

/*** 
The duplicates report command generates a table specifiying the number of 
observations and the number of surplus. In this example, the table 
illustrates that there are 32 unique observations with zero duplicates. 
If there were a duplicate, there would be a second line of the table with 
the observations and their duplicates. 
***/
	
duplicates drop

/*** 
The duplicates drop command removes all observations that are duplicates. 
As the example demonstrates, one will be notified with the number of 
observations that are dropped. 
***/

drop enrollment

/*** 
The `drop` command removes the specified variable from the data set. The 
drop command is the opposite of the `keep` command. While the drop command 
removes listed variables, the `keep` command removes all variables which 
are not specified. 
***/

drop if zip == "63139"

/*** 
The `drop` command can be used in conjunction with `if` to specify 
observations that meet certain criteria. In this example, all 
observations with `63139` in the `zip` variable will be eliminated from the 
data set. If the `keep` command were used here, only observations with 
`63139` in the `zip` variable will be left in the data set. 
*/	

// ++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++

/***
### Save and Export Clean Data
***/

save "DataClean/`projName'.dta", replace
export delimited "DataClean/`projName'.csv", replace

// ==========================================================================
// ==========================================================================
// ==========================================================================

// end MarkDoc log

/*
quietly log close tempLog
*/

// convert MarkDoc log to Markdown

markdoc "LogFile/`projName'", replace export(md)
copy "LogFile/`projName'.md" "Output/`projName'.md", replace
shell rm -R "LogFile/`projName'.md"
shell rm -R "LogFile/`projName'.smcl"

// ==========================================================================

// archive code and raw data

copy "`projName'.do" "CodeArchive/`projName'.do", replace
copy "`rawData'" "DataRaw/`rawData'", replace

// ==========================================================================

// standard closing options

log close _all
graph drop _all
set more on

// ==========================================================================

exit
