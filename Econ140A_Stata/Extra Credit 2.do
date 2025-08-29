clear all
cls
cd "~/Desktop/ECON140A_Stata/"

** NAME: [Maya Trieu]
** PERM: [A0Y1C68]
** DATE: [11/28/24]

use tracking_data.dta, clear


* QUESTION 1:
*Compute the difference between the average test score in the end of first grade among students in tracked and non-tracked schools (i.e. average for tracked minus average for non-tracked). Provide the numeric answer below, rounded to 3 decimal places. 

* computing means for different groups
summarize score_end_first_grade if tracking == 1
scalar tracked_mean = r(mean)

summarize score_end_first_grade if tracking == 0
scalar nontracked_mean = r(mean)

* difference between the means
scalar mean_difference = tracked_mean - nontracked_mean
display round(mean_difference, 0.001)


* QUESTION 2:
* Can you reject at the 5% level the null hypothesis that this difference is equal to 0?
ttest score_end_first_grade, by(tracking)
display r(t)
* |t-statistic| > 1.96 --> reject null


* QUESTION 3:
* Based on this evidence alone, does tracking improve the average end-of-year test scores of 1st grade students in Kenya?
* No, various other variables that tie into this result; can't connect it to just one


* QUESTION 4:
*Use the data to assess whether students below the median (bottomhalf = 1) are harmed by tracking, or whether they are affected by tracking in a significantly different way. 

*If you find that tracking negatively impacts below-median students, enter a 0 as your answer.

*If you find that below-median students are not negatively impacted, but are impacted differently than above-median students, provide the test statistic on a coefficient that compares the treatment effect between above-median and below-median students. Your answer must be rounded to 2 decimal places. 

* Regression with an interaction term between tracking and bottomhalf
regress score_end_first_grade i.tracking##i.bottomhalf, robust
* other stata format-same thing
regress score_end_first_grade tracking##bottomhalf, robust
* t-statistic = 0.54 --> not significant


* QUESTION 5:
* Now assume you hear the following statement in the media: "Some scientists conducted a randomized experiment. They randomly divided a population of 50 unemployed people into two groups. 25 of them followed a training during 1 day where they learnt new computer skills, while the remaining 25 did not follow this training. 1 month after the training, 60% of the 25 unemployed that had followed the training had found a new job. On the other hand, only 48% of the 25 unemployed that had not followed the training had found a new job by that time. This proves that this training has a positive impact on the percentage of unemployed that find a new job in less than 1 month, we hope it will be generalized by the government."
* Specify a correct hypothesis test and derive a a 95% confidence interval for the effect of the training on treated individuals' employment statuses (i.e. "Employment" = 1 or "Employment" = 0). According to this hypothesis test, can you determine any significant impact of the treatment on unemployed workers' outcomes? What is the point estimate and corresponding confidence interval? Note that you will need to derive a variance estimator for the ATT in order to construct the confidence interval. (Hint: recall the formula simplification of the variance estimator under binary outcome data). 
* provide absolute value of the test-statistic from this hypothesis test
clear
input group employment
1 1
1 1
1 1
1 1
1 1
1 1
1 1
1 1
1 1
1 1
1 1
1 1
1 1
1 1
1 1
1 0
1 0
1 0
1 0
1 0
1 0
1 0
1 0
1 0
1 0
0 1
0 1
0 1
0 1
0 1
0 1
0 1
0 1
0 1
0 1
0 1
0 1
0 0
0 0
0 0
0 0
0 0
0 0
0 0
0 0
0 0
0 0
0 0
0 0
0 0
end

ttest employment, by(group)
display round(r(t), 0.01)
