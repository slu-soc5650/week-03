Cleaning Data with Stata
========================

#### SOC 4650/5650: Intro to GIS

#### Christopher Prener / Kyle Miller

#### 4 February 2017

### Description

This .do file imports the MO\_HYDRO\_ImpairedRiversStreams data. Next,
it performs general cleaning on the data by renaming variables and
dropping observations.

### Dependencies

This do-file was written and executed using Stata 14.2.

It also uses the latest
[MarkDoc](https://github.com/haghish/markdoc/wiki) package via GitHub as
well as the latest versions of its dependencies:

          .  version 14
          
          . which markdoc
          /Users/prenercg/Library/Application Support/Stata/ado/plus/m/markdoc.ado
          
          . which weave
          /Users/prenercg/Library/Application Support/Stata/ado/plus/w/weave.ado
          
          . which statax
          /Users/prenercg/Library/Application Support/Stata/ado/plus/s/statax.ado
          
          

### Import/Open Data

          .  local rawData "MO_HYDRO_ImpairedRiversStreams.csv"
          
          .  import delimited `rawData', varnames(1)
          (31 vars, 6,029 obs)
          
          

**7a.** These commands import the raw data into Stata.

          .  drop businessid mdnr_impsz size_ epa_apprsz unit wb_epa comment_ eventdat ///
                   reachcode rchsmdate rch_res src_desc feat_url fmeasure tmeasure ///
                   shape_leng shape_le_1
          
          
          

**7b.** This command drops the requested variables.

          .  drop if county_u_d != "St. Louis"
          (5,850 observations deleted)
          
          

**7c.** This command drops observations where the county is not St.
Louis.

**7d.** The command isid `wbid` generates an error. Therefore, the
variable `wbid` does not uniquely identify each observations.

**7e.** The command isid `perm_id` demonstrates some missing
observations. Therefore, the variable `perm_id` does not uniquely
identify each observations.

          .  tabulate perm_id, missing
          
                                         PERM_ID |      Freq.     Percent        Cum.
          ---------------------------------------+-----------------------------------
                                                 |         32       17.88       17.88
          {0B5063BC-00FD-4975-814A-4BD48E1836FD} |          2        1.12       18.99
          {0BEDE6B9-9BA1-434C-B9BD-5B6A0E2D8C49} |          3        1.68       20.67
          {120AE41B-A6B2-4D43-81DF-B3CE0565621B} |          2        1.12       21.79
          {19021829-58EA-4E20-ABDE-A061978B8139} |          2        1.12       22.91
          {1E2BD1CE-9AE6-4F6D-9711-F1897D5A5288} |          2        1.12       24.02
          {252B26AE-E96C-4F22-9B84-3BDE1D3C4C99} |          2        1.12       25.14
          {2809878B-45DF-45B4-8EEE-19EB3670FCFD} |          2        1.12       26.26
          {29525EE5-C8C7-4E38-A898-B6806F8B31BC} |          2        1.12       27.37
          {2B89AB15-6388-468D-BA66-4531E8976725} |          2        1.12       28.49
          {2C6D7A06-9EA0-4CC1-AC98-B046E68F9177} |          1        0.56       29.05
          {349DADA4-7AFB-44F6-BD56-51FE8D9644FE} |          2        1.12       30.17
          {387C7A17-63E7-4147-8695-24DDA8915775} |          2        1.12       31.28
          {39F3C4CE-F83C-4F8C-B84D-72635DB0C9F5} |          2        1.12       32.40
          {3AE200BC-B16E-431B-A560-197207F292E8} |          1        0.56       32.96
          {3C862C61-9BC2-4E0F-B800-D256AAF8ED95} |          2        1.12       34.08
          {3CF5DF1C-DDDB-471A-BFA6-6ECD7F614DA2} |          2        1.12       35.20
          {44435135-2D54-4042-B68C-8F9B260C746B} |          2        1.12       36.31
          {494CAD5C-74E8-430A-88EE-714C59A5F9F7} |          2        1.12       37.43
          {4C0066E9-3E43-40EF-9594-FF4D9B4605FF} |          2        1.12       38.55
          {4C7744D9-23A7-42A8-AB29-F7E125CF1A57} |          2        1.12       39.66
          {4D132A85-F5FB-49B3-AF02-C60F8EEBF3B0} |          1        0.56       40.22
          {4FDE6F9C-F79C-4BC4-8A21-54A4F272F33E} |          1        0.56       40.78
          {595820C2-4D86-4B31-B168-05D7C4526A21} |          2        1.12       41.90
          {5A8DCD75-5A82-4EEA-B521-4D5237DBC6B3} |          1        0.56       42.46
          {6216135D-7FB7-4F3B-A594-CEDDC1AAA56F} |          2        1.12       43.58
          {62FCEDDC-4A60-4AAA-B396-1E50C04AB7AC} |          1        0.56       44.13
          {666A2E58-FD88-4551-84B4-C87EC1B012CE} |          3        1.68       45.81
          {680AE34A-A46F-4CDC-BF0E-08DA3E8D6FB9} |          2        1.12       46.93
          {726C4485-9ED8-4E4A-AC2A-7367BC819984} |          3        1.68       48.60
          {73F8A477-C985-4903-B0B7-185568955414} |          3        1.68       50.28
          {7BAB2D5B-6114-418D-B2D7-7DEC2B8C9C63} |          1        0.56       50.84
          {7C2341DA-174B-46F0-8505-C35C22C3661D} |          2        1.12       51.96
          {7F6ADCC3-19B0-470F-AC7B-1BCBA2693DC3} |          1        0.56       52.51
          {7FF4AB75-0F9E-44B1-840D-5CD2DE85337F} |          3        1.68       54.19
          {80D99CFF-02E6-465F-9848-BED0D9FE8AC6} |          1        0.56       54.75
          {8B9E9844-B5CD-44BF-AA5D-3058585A9028} |          3        1.68       56.42
          {92F48E2D-363B-4604-B7E7-FBF7C6618C58} |          2        1.12       57.54
          {967B6A7B-5684-47B1-B780-60DC57BD2832} |          1        0.56       58.10
          {A3F8B26E-97E8-46DF-8947-ADB402DDB825} |          3        1.68       59.78
          {A9763999-0057-4E24-B216-F3CF3CD5BF54} |          3        1.68       61.45
          {A9BD5370-40A2-4C64-8243-7FDAB99E7107} |          2        1.12       62.57
          {AB8E7E5C-2C53-4C8A-A1F4-1B5EF631EE7B} |          2        1.12       63.69
          {B32DF6EC-A64D-4E9C-9106-D984F370F81E} |          3        1.68       65.36
          {B363237F-1DE4-48E0-94AE-9FE965A9D7BF} |          2        1.12       66.48
          {B4FDB7F4-185B-411E-8197-CD787B244D06} |          2        1.12       67.60
          {BB1C2E0A-6F76-45AA-B623-9C4EF23316C0} |          1        0.56       68.16
          {BFBBA3B4-D8A8-4DA8-9D0B-30104D79A79D} |          2        1.12       69.27
          {C3CE649B-070C-4124-A8E1-F90136F401D2} |          1        0.56       69.83
          {C56ED959-10B9-44F8-B0D8-3D6BF72FC55D} |          1        0.56       70.39
          {CB0E9371-B210-4D04-9DC2-1CBF1017F718} |          1        0.56       70.95
          {CBBC6C16-794E-4B2C-A552-17443B84D4C3} |          2        1.12       72.07
          {CEE5577A-C9EF-4266-8BB6-E6ABA694B07D} |          1        0.56       72.63
          {CF03D888-9C16-48C4-B78A-7176F11F090A} |          2        1.12       73.74
          {D0C44980-44F9-4ED6-B792-B1EFFB585A79} |          1        0.56       74.30
          {D2D4331E-6099-497E-AA56-93B873D1E88D} |          2        1.12       75.42
          {D5DB8788-0336-482E-AD30-F66E8F0A97B1} |          3        1.68       77.09
          {D68F5CFB-8F3F-4B62-B05D-850FB41FBA0F} |          2        1.12       78.21
          {D845EEA4-BFBA-47AE-B5F3-E3889706BB75} |          2        1.12       79.33
          {DCD1D64F-3C01-456D-B512-ECD754D4A182} |          1        0.56       79.89
          {DD4E5792-74B8-4EA4-B15A-36897FBF9A7B} |          2        1.12       81.01
          {DF744A34-0B42-4B51-A955-CA84FD49FB8B} |          3        1.68       82.68
          {E1C41CC7-6A4D-4E6C-9E0A-E37D711425E3} |          3        1.68       84.36
          {E245FB70-A8C9-404A-A0C1-AD6F68B92BCA} |          1        0.56       84.92
          {E312F8E9-743F-4DD2-8835-CE137B79D443} |          2        1.12       86.03
          {E6B874E6-96FB-4274-B934-DF9812484EE8} |          2        1.12       87.15
          {E7232DB6-8F20-4E66-9E1C-4061204A0300} |          3        1.68       88.83
          {E908B828-A3AA-4AFF-8287-1549968BFADB} |          2        1.12       89.94
          {ED87A117-23A9-49FC-99B5-23B41723FFE5} |          1        0.56       90.50
          {EE1B350E-3277-40A4-932B-6BD153E85D08} |          1        0.56       91.06
          {EEC63D56-054D-47D9-9235-09EAA48D685C} |          2        1.12       92.18
          {F05BB3D9-E31A-4360-8D62-0E21A512A725} |          2        1.12       93.30
          {F09FF66A-9F38-4675-95F4-98CBEB77D32A} |          3        1.68       94.97
          {F578AB75-9EC2-43C0-A43D-D0CB7EA7B29C} |          2        1.12       96.09
          {F8831A76-3440-4EDA-964A-EE9841FD4D8D} |          2        1.12       97.21
          {F9A8E27D-BE19-4FB4-8FDD-D26CE6D833E7} |          2        1.12       98.32
          {FBAF40AB-E341-48A7-82E8-AF9BFD809C95} |          2        1.12       99.44
          {FC8E6E86-E12C-48AF-A134-2171306389D3} |          1        0.56      100.00
          ---------------------------------------+-----------------------------------
                                           Total |        179      100.00
          
          

**7f.** There are thirty-two observations with missing data for the
perm\_id variable.

          .  drop perm_id
          
          

**7g.** This command drops the variable `perm_id`.

          .  rename source_ source
          
          
          

**7h.** This command renames the variable `source_` to `source`. By
removing the underscore, the variable name is simpler.

          .  rename county_u_d county
          
          
          

**7i.** This command renames the variable `county_u_d` to `county`. By
removing the content at the end of the original variable name, we get a
simpler variable name.

          .  duplicates report
          
          Duplicates in terms of all variables
          
          --------------------------------------
             copies | observations       surplus
          ----------+---------------------------
                  1 |            4             0
                  2 |           22            11
                  3 |           12             8
                  4 |           20            15
                  5 |           25            20
                  6 |           12            10
                  7 |            7             6
                  8 |            8             7
                  9 |           27            24
                 12 |           12            11
                 15 |           30            28
          --------------------------------------
          
          

**7j.** There are 39 unique observations in the
`MO_HYDRO_ImpairedRiversStreams` data set. Most observations have at
least one duplicate.

          .  duplicates drop
          
          Duplicates in terms of all variables
          
          (140 observations deleted)
          
          

**7k.** There were 140 observations dropped after using the duplicates
drop command.

          .  replace water_body = "Fee Fee Cr." if water_body == "Fee Fee Cr. (new)"
          (2 real changes made)
          
          

**7l.** This command fixes the naming of "Fee Fee Cr." so that it does
not have the "(new)" text included in the water body name.

**8a.** Yes, the variables are stored in unqiue columns that only
identify one concept.

**8b.** Yes, each observation forms a row with no duplicates.

**8c.** After the data set has been cleaned, thirty-nine observations
remain.

**8d.** The observation unit of the data set is a pollutant in a body of
water. This means that, if a body of water has multiple polluntants, it
will be listed multiple times in the dataset.

**8e.** The data could be considered clean due to the fact that all
observations have a similar format. However, there are multiple
variables whose meanings are not clear.

**8f.** The meaning of the variables `iu` and `ou`, including what the
individual values mean, could be clearer. Additionally, the `source`
variable could be simplified.

### Save and Export Clean Data

          .  save "DataClean/`projName'.dta", replace
          file DataClean/listedStreams.dta saved
          
          . export delimited "DataClean/`projName'.csv", replace
          file DataClean/listedStreams.csv saved
          
