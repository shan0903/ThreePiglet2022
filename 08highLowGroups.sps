* open file generated in 04.txt.
GET DATA /TYPE=XLSX
  /FILE='C:\我的师大云盘\Spatial development\fromServer\data4shanxu\scripts_xs\dat_20modelling.xlsx'
  /SHEET=name 'Sheet1'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=32767.
EXECUTE.
DATASET NAME dataset20modelling WINDOW=FRONT.

* reorganize the file to combine the score of the same participants into a case.
SORT CASES BY SID reOrder.
CASESTOVARS
  /ID=SID
  /INDEX=reOrder
  /GROUPBY=VARIABLE.

* select unwanted variables..
Delete variables V1.2 to V1.21.
Delete variables TbSig.2 to TaSig.21.
Delete variables Tb.2 to SST.21.

* save the output.
SAVE TRANSLATE OUTFILE='C:\我的师大云盘\Spatial development\pssubmission\datarep\dat_20trials_replicate.xlsx'
  /TYPE=XLS
  /VERSION=12
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES.

* select participants in the first 6 age bins.
USE ALL.
COMPUTE filter_$=(Age < 35).
VARIABLE LABELS filter_$ 'Age < 35 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

*Calculate the 20 and 80 percentile across age.
FREQUENCIES VARIABLES=Score.2
  /FORMAT=NOTABLE
  /PERCENTILES=20.0 80.0 
  /ORDER=ANALYSIS.

* label the participants in the high and low group.
IF  (Score.2 <= 2.2) hlall20=10.
EXECUTE.
IF  (Score.2 >= 11)  hlall20=1.
EXECUTE.

*Get the data for the mean scaling factor of each group and their learning curve.
SORT CASES  BY hlall20.
SPLIT FILE SEPARATE BY hlall20.

DESCRIPTIVES VARIABLES=b Score.2 Score.3 Score.4 Score.5 Score.6 Score.7 Score.8 Score.9 Score.10 
    Score.11 Score.12 Score.13 Score.14 Score.15 Score.16 Score.17 Score.18 Score.19 Score.20 Score.21
  /STATISTICS=MEAN STDDEV.

*. label the high and low group of each age bin.
SPLIT FILE OFF.
USE ALL.
COMPUTE filter_$=(Age < 35).
VARIABLE LABELS filter_$ 'Age < 35 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

SORT CASES  BY Age.
SPLIT FILE SEPARATE BY Age.

FREQUENCIES VARIABLES=Score.2
  /FORMAT=NOTABLE
  /PERCENTILES=20.0 80.0 
  /ORDER=ANALYSIS.

IF  ( Age = 5 & Score.2<=1.1
) hlage20=1.
EXECUTE.
IF  ( Age = 5 & Score.2>=5.378
) hlage20=10.
EXECUTE.

IF  ( Age = 13 & Score.2<=2.2
) hlage20=1.
EXECUTE.
IF  ( Age = 13 & Score.2>=10.6
) hlage20=10.
EXECUTE.

IF  ( Age = 18 & Score.2<=2.1
) hlage20=1.
EXECUTE.
IF  ( Age = 18 & Score.2>=10.5
) hlage20=10.
EXECUTE.

IF  ( Age = 23 & Score.2<=2.2
) hlage20=1.
EXECUTE.
IF  ( Age = 23 & Score.2>=12.6
) hlage20=10.
EXECUTE.

IF  ( Age = 28 & Score.2<=2.2
) hlage20=1.
EXECUTE.
IF  ( Age = 28 & Score.2>=11.8
) hlage20=10.
EXECUTE.

IF  ( Age = 33 & Score.2<=2.2
) hlage20=1.
EXECUTE.
IF  ( Age = 33 & Score.2>=11.69
) hlage20=10.
EXECUTE.

*Get the data for the mean scaling factor of each group and their learning curve.
SORT CASES  BY Age hlage20.
SPLIT FILE SEPARATE BY Age hlage20.
DESCRIPTIVES VARIABLES=b Score.2 Score.3 Score.4 Score.5 Score.6 Score.7 Score.8 Score.9 Score.10 
    Score.11 Score.12 Score.13 Score.14 Score.15 Score.16 Score.17 Score.18 Score.19 Score.20 Score.21
  /STATISTICS=MEAN STDDEV.


