* the directory need to be changed to where all the sps file is saved.
GET DATA /TYPE=XLSX
  /FILE='C:\我的师大云盘\Spatial development\pssubmission\datarep\dat_T2_replicate.xlsx'
  /SHEET=name 'Sheet1'
  /CELLRANGE=full
  /READNAMES=on
  /ASSUMEDSTRWIDTH=32767.
EXECUTE.
DATASET NAME T2 WINDOW=FRONT.

*generate a computed variable 'age10', in which participants reporting above 50 yrs old were coded into a same age category "53" (means 50+).
DATASET ACTIVATE T2.
IF  (Age > 53) age10=53.
EXECUTE.
IF  (Age <= 53) age10=Age.
EXECUTE.

*select participants with age information.
USE ALL.
COMPUTE filter_$=(age10 > 0).
VARIABLE LABELS filter_$ 'age10 > 0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

*One-way ANOVA with age10 as independent variable and performance (the second non-zero score) as the dependent variable.
UNIANOVA Score BY age10
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /POSTHOC=age10(LSD) 
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(age10) 
  /PRINT=ETASQ DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=age10.

*select participants with gender information.
USE ALL.
COMPUTE filter_$=(Sex > 0).
VARIABLE LABELS filter_$ 'Sex > 0 (FILTER)'.
VALUE LABELS filter_$ 0 'Not Selected' 1 'Selected'.
FORMATS filter_$ (f1.0).
FILTER BY filter_$.
EXECUTE.

*Two-way ANOVA with age and gender as between-subject factors and performance (the second non-zero score) as the dependent variable.
UNIANOVA Score BY age10 Sex
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /POSTHOC=age10 Sex(LSD) 
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(age10) 
  /EMMEANS=TABLES(Sex) 
  /EMMEANS=TABLES(age10*Sex) compare (Sex)
  /PRINT=ETASQ DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=age10 Sex age10*Sex.

*calculate the mean and SD of each gender.
UNIANOVA Score BY Sex
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /POSTHOC=Sex(LSD) 
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(Sex) 
  /PRINT=ETASQ DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=Sex.

*generate a computed variable 'NormalizedSocre2'
in which scores of mental rotation performance of each gender 
were standardized into z scores by subtracting the mean scores 
of the respective gender and then dividing each remainder 
by the standard deviation.
IF  (Sex = 1) NormalizedSocre2=(Score-8.588)/7.296.
EXECUTE.
IF  (Sex = 2) NormalizedSocre2=(Score-6.946)/5.867.
EXECUTE.

*the two-way ANOVA with age10 and gender as between-subject factors and standardized performance as the dependent variable.
UNIANOVA NormalizedSocre2 BY Sex age10
  /METHOD=SSTYPE(3)
  /INTERCEPT=INCLUDE
  /POSTHOC=Sex age10(LSD) 
  /EMMEANS=TABLES(OVERALL) 
  /EMMEANS=TABLES(Sex) 
  /EMMEANS=TABLES(age10) 
  /EMMEANS=TABLES(Sex*age10) 
  /PRINT=ETASQ DESCRIPTIVE
  /CRITERIA=ALPHA(.05)
  /DESIGN=Sex age10 Sex*age10.
