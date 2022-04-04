*import the bootstrap data.
* the directory need to be changed to where all the sps file is saved.
GET DATA /TYPE=XLSX
  /FILE='C:\我的师大云盘\Spatial development\pssubmission\datarep\bootstrap_replicate.xlsx'
  /SHEET=name 'Sheet1'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=32767.
EXECUTE.
DATASET NAME bootstrap WINDOW=FRONT.

*show the descriptives of b and score2.
DATASET ACTIVATE bootstrap.
FREQUENCIES VARIABLES=b score2
  /FORMAT=NOTABLE
  /PERCENTILES=25.0 75.0 
  /STATISTICS=STDDEV MINIMUM MAXIMUM SEMEAN MEAN MEDIAN
  /ORDER=ANALYSIS.