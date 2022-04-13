GET DATA /TYPE=XLSX
  /FILE='\path_to_your_directory\schoolMR.xlsx'
  /SHEET=name 'Sheet1'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=32767.
EXECUTE.

COMPUTE accM2=MirrorTotal.2 / 12.
EXECUTE.
COMPUTE accM3=MirrorTotal.3 / 12.
EXECUTE.
COMPUTE accNM2=nonMirrorTotal.2 / 12.
EXECUTE.
COMPUTE accNM3=nonMirrorTotal.3 / 12.
EXECUTE.

ONEWAY accM2 accM3 accNM2 accNM3 BY age
  /STATISTICS DESCRIPTIVES 
  /MISSING ANALYSIS.
