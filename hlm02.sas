/* --- file: hlm02.sas ---
	example of nested ANOVA or hierarchical linear models

	morphometric data on leaves gathered from various
	locations in two climates, temperate or tropical.
	in theis case location is nested within climate.
	fabricated data.

	the dependent variable, has low values for roundish
	leaves and high values for more ovalish leaves
	 --- */


TITLE Example of random nested effects, AKA hierarchical linear models;
TITLE2 'leaf morphometrics';

DATA leaves;
   LENGTH climate $9;
   INPUT climate location sample ovalish;
   LABEL ovalish = 'Round versus Oval';
DATALINES;
temperate        1     1  -0.354
temperate        1     2   0.663
temperate        1     3  -0.069
temperate        1     4  -1.383
temperate        2     1   0.449
temperate        2     2  -1.656
temperate        2     3  -1.509
temperate        2     4  -1.764
temperate        2     5  -0.857
temperate        2     6   0.120
temperate        2     7  -1.720
temperate        2     8  -0.032
temperate        3     1   0.917
temperate        3     2   0.343
temperate        3     3   0.789
temperate        3     4  -0.864
temperate        4     1   0.929
temperate        4     2  -0.848
temperate        4     3   0.103
temperate        4     4  -0.722
tropical        1     1  -1.177
tropical        1     2   1.024
tropical        1     3  -1.394
tropical        1     4   0.052
tropical        1     5   0.227
tropical        1     6   1.025
tropical        1     7  -0.623
tropical        1     8  -0.322
tropical        2     1   0.371
tropical        2     2   3.715
tropical        2     3   1.246
tropical        2     4   0.769
tropical        2     5   0.926
tropical        2     6   0.747
tropical        3     1   1.468
tropical        3     2   2.430
tropical        3     3   3.491
tropical        3     4   0.233
RUN;


PROC GLM DATA=leaves;
   CLASS climate location;
   MODEL ovalish = climate location(climate);
   RUN;
   * - now treat location(climate) as a random variable;
   TITLE3 Note how the climate effect is no longer significant;
   RANDOM location(climate)  / TEST;
   MEANS climate location(climate);
RUN;
QUIT;
