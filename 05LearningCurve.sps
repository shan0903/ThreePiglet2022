* read the reordered data.
* the directory need to be changed to where all the sps file is saved.
GET DATA /TYPE=XLSX
  /FILE='C:\我的师大云盘\Spatial development\pssubmission\datarep\dat_reOrderNozeros_replicate.xlsx'
  /SHEET=name 'Sheet1'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=32767.
EXECUTE.
DATASET NAME dat_reorder_nonzeros WINDOW=FRONT.

DATASET ACTIVATE dat_reorder_nonzeros.

*Get the mean score of each repetition from the marginal means tables.
ONEWAY Score BY reOrder
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS.
