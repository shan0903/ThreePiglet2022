*for 10 plays.
* the directory need to be changed to where all the sps file is saved.
GET DATA /TYPE=XLSX
  /FILE='C:\我的师大云盘\Spatial development\pssubmission\datarep\dat_10modeled_replicate.xlsx'
  /SHEET=name 'Sheet1'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=32767.
EXECUTE.
DATASET NAME 10modeled WINDOW=FRONT.

*select participants of the first 6 age bins and their 11 non-zeros play.
USE ALL.
COMPUTE filter_$=(Age < 35 & reOrder = 11).
VARIABLE LABELS filter_$ 'Age < 35 & reOrder = 11 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

*get the mean b of each age bin and get the pairwise comparison between neighboring groups.
ONEWAY b BY Age
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS
  /POSTHOC=LSD ALPHA(0.05).

*for 30 plays.
* the directory need to be changed to where all the sps file is saved.
GET DATA /TYPE=XLSX
  /FILE='C:\我的师大云盘\Spatial development\pssubmission\datarep\dat_30modeled_replicate.xlsx'
  /SHEET=name 'Sheet1'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=32767.
EXECUTE.
DATASET NAME 30modeled WINDOW=FRONT.

*select participants of the first 6 age bins and their 31 non-zeros play.
USE ALL.
COMPUTE filter_$=(Age < 35 & reOrder = 31).
VARIABLE LABELS filter_$ 'Age < 35 & reOrder = 31 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

*get the mean b of each age bin and get the pairwise comparison between neighboring groups.
ONEWAY b BY Age
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS
  /POSTHOC=LSD ALPHA(0.05).
