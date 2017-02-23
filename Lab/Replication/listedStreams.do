// ==========================================================================

// Lab-03 Replication

// ==========================================================================

// define project name

local projName "listedStreams"

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
# Cleaning Data with Stata
#### SOC 4650/5650: Intro to GIS
#### Christopher Prener / Kyle Miller
#### 4 February 2017

### Description
This .do file imports the MO_HYDRO_ImpairedRiversStreams data. Next, it 
performs general cleaning on the data by renaming variables and dropping 
observations.

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

local rawData "MO_HYDRO_ImpairedRiversStreams.csv"

import delimited `rawData', varnames(1)

/***
**7a.** These commands import the raw data into Stata.
***/

drop businessid mdnr_impsz size_ epa_apprsz unit wb_epa comment_ eventdat ///
	reachcode rchsmdate rch_res src_desc feat_url fmeasure tmeasure ///
	shape_leng shape_le_1

/***
**7b.** This command drops the requested variables.
***/

drop if county_u_d != "St. Louis"

/***
**7c.** This command drops observations where the county is not St. Louis.
***/

// isid wbid

/***
**7d.** The command isid `wbid` generates an error. Therefore, the variable 
`wbid` does not uniquely identify each observations.
***/

// isid perm_id

/***
**7e.** The command isid `perm_id` demonstrates some missing observations. 
Therefore, the variable `perm_id` does not uniquely identify each observations.
***/

tabulate perm_id, missing

/***
**7f.** There are thirty-two observations with missing data for the perm_id 
variable.
***/

drop perm_id

/***
**7g.** This command drops the variable `perm_id`.
***/

rename source_ source

/***
**7h.** This command renames the variable `source_` to `source`. By removing
the underscore, the variable name is simpler.
***/

rename county_u_d county

/***
**7i.** This command renames the variable `county_u_d` to `county`. By removing
the content at the end of the original variable name, we get a simpler
variable name.
***/

duplicates report

/***
**7j.** There are 39 unique observations in the 
`MO_HYDRO_ImpairedRiversStreams` data set. Most observations have at least
one duplicate.
***/

duplicates drop

/***
**7k.** There were 140 observations dropped after using the duplicates drop 
command.
***/

replace water_body = "Fee Fee Cr." if water_body == "Fee Fee Cr. (new)"

/***
**7l.** This command fixes the naming of "Fee Fee Cr." so that it does not
have the "(new)" text included in the water body name.

**8a.** Yes, the variables are stored in unqiue columns that only identify 
one concept.

**8b.** Yes, each observation forms a row with no duplicates.

**8c.** After the data set has been cleaned, thirty-nine observations remain.

**8d.** The observation unit of the data set is a pollutant in a body of
water. This means that, if a body of water has multiple polluntants, it will
be listed multiple times in the dataset.

**8e.** The data could be considered clean due to the fact that all 
observations have a similar format. However, there are multiple variables 
whose meanings are not clear.

**8f.** The meaning of the variables `iu` and `ou`, including what the 
individual values mean, could be clearer. Additionally, the `source` variable
could be simplified.
***/

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
