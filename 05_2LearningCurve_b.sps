* the directory need to be changed to where all the sps file is saved.
GET DATA /TYPE=XLSX
  /FILE='C:\我的师大云盘\Spatial development\pssubmission\datarep\dat_20modeled_replicate.xlsx'
  /SHEET=name 'Sheet1'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=32767.
EXECUTE.
DATASET NAME 20modeled WINDOW=FRONT.

*select the S20th non-zero score of the participants in the first 6 age bins nad 
USE ALL.
COMPUTE filter_$=(Age < 35  &  reOrder = 21).
VARIABLE LABELS filter_$ 'Age < 35  &  reOrder = 21 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

*One-way ANOVA with age as IV and malleability (scaling factor) as DV.
UNIANOVA b BY Age
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /POSTHOC=Age(LSD) 
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(Age) 
  /PRINT=OPOWER ETASQ DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=Age.

*generate data (from the marginal means table) to draw the learning curves of each age bin.
USE ALL.
COMPUTE filter_$=(Age < 35).
VARIABLE LABELS filter_$ 'Age < 35 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

UNIANOVA b BY Age reOrder
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(Age) 
  /EMMEANS=TABLES(reOrder) 
  /EMMEANS=TABLES(Age*reOrder) 
  /PRINT=OPOWER ETASQ DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=Age reOrder Age*reOrder.
