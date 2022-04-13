GET DATA /TYPE=XLSX
  /FILE='\path_to_your_directory\dat_20max_replicate.xlsx'
  /SHEET=name 'Sheet1'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=32767.
EXECUTE.
DATASET NAME 20max WINDOW=FRONT.

*select the records of the 21st play of each participants.
USE ALL.
COMPUTE filter_$=( reOrder = 21 & Age < 35).
VARIABLE LABELS filter_$ ' reOrder = 21 & Age < 35 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

*one way anova with age as IV and change as DV.
UNIANOVA changeIn20 BY Age
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(Age) 
  /PRINT=ETASQ DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=Age.


* test the difference between neighboring age groups.
T-TEST GROUPS=Age(5 13)
  /MISSING=ANALYSIS
  /VARIABLES=changeIn20
  /CRITERIA=CI(.95).

T-TEST GROUPS=Age(13 18)
  /MISSING=ANALYSIS
  /VARIABLES=changeIn20
  /CRITERIA=CI(.95).
T-TEST GROUPS=Age(18 23)
  /MISSING=ANALYSIS
  /VARIABLES=changeIn20
  /CRITERIA=CI(.95).
T-TEST GROUPS=Age(23 28)
  /MISSING=ANALYSIS
  /VARIABLES=changeIn20
  /CRITERIA=CI(.95).

*compute standardized change index and scalling factor index.
DESCRIPTIVES VARIABLES=changeIn20 b
  /SAVE
  /STATISTICS=MEAN STDDEV.

* run two way anova with index as within subject IV, age as between subject IV.
GLM ZchangeIn20 Zb WITH Age
  /WSFACTOR=index 2 Polynomial 
  /METHOD=SSTYPE(3)
  /CRITERIA=ALPHA(.05)
  /WSDESIGN=index 
  /DESIGN=Age.




