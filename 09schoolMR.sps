GET
  FILE='C:\我的师大云盘\Spatial development\pssubmission\datarep\schoolMR.sav'.
DATASET NAME schoolMR WINDOW=FRONT.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT MirrorTotal.2
  /METHOD=ENTER nonMirrorTotal.2
  /SAVE ZRESID.

REGRESSION
  /MISSING LISTWISE
  /STATISTICS COEFF OUTS R ANOVA
  /CRITERIA=PIN(.05) POUT(.10)
  /NOORIGIN 
  /DEPENDENT MirrorTotal.3
  /METHOD=ENTER nonMirrorTotal.3
  /SAVE ZRESID.

Rename variable ZRE_1=ZRE_mNm2.
Rename variable ZRE_2=ZRE_mNm3.

FILTER OFF.
USE ALL.
SELECT IF (age > 0 & age < 14).
EXECUTE.

SAVE TRANSLATE OUTFILE='C:\我的师大云盘\Spatial development\pssubmission\datarep\schoolMR.xlsx'
  /TYPE=XLS
  /VERSION=12
  /MAP
  /REPLACE
  /FIELDNAMES
  /CELLS=VALUES.


