* for the 10-play data.
* the directory need to be changed to where all the sps file is saved.
GET DATA /TYPE=XLSX
  /FILE='C:\我的师大云盘\Spatial development\pssubmission\datarep\bootstrap_10_replicate.xlsx'
  /SHEET=name 'Sheet1'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=32767.
EXECUTE.
DATASET NAME bootstrap10 WINDOW=FRONT.

*show the descriptives of b and score2.
DATASET ACTIVATE bootstrap10.
FREQUENCIES VARIABLES=b score2
  /FORMAT=NOTABLE
  /PERCENTILES=25.0 75.0 
  /STATISTICS=STDDEV MINIMUM MAXIMUM SEMEAN MEAN MEDIAN
  /ORDER=ANALYSIS.

*for the 30-play data.
* the directory need to be changed to where all the sps file is saved.
GET DATA /TYPE=XLSX
  /FILE='C:\我的师大云盘\Spatial development\pssubmission\datarep\bootstrap_30_replicate.xlsx'
  /SHEET=name 'Sheet1'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=32767.
EXECUTE.
DATASET NAME bootstrap30 WINDOW=FRONT.

*show the descriptives of b and score2.
DATASET ACTIVATE bootstrap30.
FREQUENCIES VARIABLES=b score2
  /FORMAT=NOTABLE
  /PERCENTILES=25.0 75.0 
  /STATISTICS=STDDEV MINIMUM MAXIMUM SEMEAN MEAN MEDIAN
  /ORDER=ANALYSIS.
