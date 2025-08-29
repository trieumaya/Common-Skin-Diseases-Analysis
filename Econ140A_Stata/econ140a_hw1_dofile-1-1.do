clear all
cls
cd "~/Desktop/ECON140A_Stata/"  //<--- Insert your working directory here and delete this comment

* Reminder: Questions 1-5 and 11 are only needed to obtain full credit (100%)

** NAME: [Maya Trieu]
** PERM: [A0Y1C68]
** DATE: [11/24/24]
** PARTNERS: [Insert Names of Collaborating Partners]


********************************************************************************
***** Question 1 *****
********************************************************************************
*Among those who answered the question (N students), what is the percentage of your classmates in favor of increasing tuition fees by 50 dollars to implement new security measures and ensure Isla Vista is safer during weekends? Hereafter, let p denote that number.
* In your answer, provide the number p, rounded to the third decimal place (i.e. if p = 0.7531, your answer would be 0.753). 
* Insert Code for Question 1

use background_survey.dta, clear
* % of students in favor of increasing tuition fees
tabulate IV_weekend_safety_fee
display round(r(mean), 0.001)

********************************************************************************
***** Question 2 *****
********************************************************************************
*Compute the percentage of students in favor of increasing tuition fees to implement security measures in IV, in the first random sample of students (those with randomdraw=1). This percentage is your estimate of p based on the first random sample. 

*In your answer, provide the estimate for p, rounded to the third decimal place. 
* Insert Code for Question 2

tabulate IV_weekend_safety_fee if randomdraw == 1
display round(r(mean), 0.001)

********************************************************************************
***** Question 3 *****
********************************************************************************
*Compute the percentage of students in favor of this measure in the 9 other random samples. Using the 10 estimated numbers of p from each random draw group, what is the variance of the estimates?

*In your answer, provide the variance of the 10 estimates, rounded to the third decimal place. 

* Insert Code for Question 3
tabstat IV_weekend_safety_fee, by(randomdraw) stats(mean)
* storing means
bys randomdraw: egen p = mean(IV_weekend_safety_fee)
* finding variance
summarize p
display round(r(Var), 0.001)


********************************************************************************
***** Question 4 *****
********************************************************************************
* According to what we saw in lecture, the variance of 𝑝̂ is equal to p(1-p)/n * (1-n/N), (the term comes from the fact the sample is drawn without replacement). Given the value of p you found in question 1, compute that number. Is the number you found very far from the number you found in question 3?

*Recall: N is the population size, while n is the sample size. The class population size is 387 students, and the number of samples from  randomdraw is 10. For simplicity, let n~39. 

* In your answer, provide the exact value of the variance of the estimator, rounded to the third decimal place. 
* Insert Code for Question 4
mean IV_weekend_safety_fee
local p = .498708 
local N = 387 // pop size
local n = 39 // ~ sample size
local variance = ((`p' * (1 - `p')) / `n') * (1 - (`n' / `N'))
display "The variance is: " round(`variance', 0.001)


********************************************************************************
***** Question 5 *****
********************************************************************************
*For each of the 10 samples of students, compute the 95% confidence interval for p according to the formula we saw during lecture, and assess whether p indeed belongs to that interval.

*For what proportion of these 10 samples does p indeed belong to the confidence interval? Does that make sense? 

*In your answer, provide the number of the confidence intervals (at most 10) that do indeed contain the true parameter, p. 

* Insert Code for Question 5
* CI for each sample
foreach i of numlist 1/10 {
    display "Group `i'"
    ci means IV_weekend_safety_fee if randomdraw == `i'
}

********************************************************************************
***** Question 6 *****
********************************************************************************
*Compare the percentage of students in favor of increasing tuition fees to implement new security measures in IV among male and among female students. Is the difference between the two groups statistically significant at the 5% level?

*In your answer, provide the absolute value of t-statistic of this test for Gender, rounded to the second decimal place.
* Insert Code for Question 6
ttest IV_weekend_safety_fee, by(Gender) unequal level(95)
local t_stat = r(t)
display "The t-statistic for Gender is: " round(`t_stat', 0.01)

********************************************************************************
***** Question 7 *****
********************************************************************************
*Compare the percentage of students in favor of increasing tuition fees to implement new security measures in IV, among students with a job and students without a job. Is the difference between the two groups statistically significant at the 5% level? If the difference is statistically significant, try to explain what causes this difference

*In your answer, provide the absolute value of t-statistic of this test for Job, rounded to the second decimal place. 
* Insert Code for Question 7
ttest IV_weekend_safety_fee, by(Job) unequal level(95)
local t_stat = r(t)
display "The t-statistic for Job is: " round(`t_stat', 0.01)


********************************************************************************
***** Question 8 *****
********************************************************************************
*When asked whether they would have answered the survey if it had not been worth 4% of the final grade, those who said they would still have replied are coded Non_response=0, while those who said they would not have replied are coded Non_response=1. The first group consists of students who answer surveys even if they do not have an incentive to do so, so let's call them always respondents. The second group consists of students who only answer surveys if they have an incentive to do so, so let's call them incentivized respondents. If there had not been an incentive to answer this survey, only the always respondents would have answered.

*What would the response rate have been in this case? Compare the percentage of females among the always respondents and to the percentage of females among the incentivized respondents. Is the difference between the two groups statistically significant at the 5% level?

*In your answer, provide the absolute value of t-statistic of this test on non-respondents, rounded to the second decimal place. 
* Insert Code for Question 8
tabulate Gender Non_response

* T-test: compare proportion of females between always&incentivized respondents
ttest Gender, by(Non_response) unequal level(95)
*ttest Gender, by(Non_response) 


* looking at significance
regress Gender i.Non_response, robust


********************************************************************************
***** Question 9 *****
********************************************************************************
*Compare the percentage of students in favor of increasing tuition fees to implement new security measures in IV among the always respondents and the incentivized respondents. Is the difference between the two groups statistically significant at the 5% level?

*In your answer, provide the absolute value of t-statistic of this test on non-respondents, rounded to the second decimal place. 
* Insert Code for Question 9
tabulate Non_response
* Compare support for the weekend safety fee between always and incentivized respondents
ttest IV_weekend_safety_fee, by(Non_response) unequal level(95)
regress IV_weekend_safety_fee i.Non_response, robust

local t_stat = r(t)
display "The t-statistic for Non-response groups is: " round(`t_stat', 0.01)


********************************************************************************
***** Question 10 *****
********************************************************************************
*Assume the university wants to know whether it should increase tuition fees by 50 dollars to implement new security measures in IV. To make that decision, they will survey students, and they will implement this measure if more than 50% of the students that respond to their survey are in favor of this idea. Only the always respondents will respond to the survey, because there is no incentive to respond. Do you think that the results of the survey can give the university a reliable measure of whether more or less than 50% of students are in favor of that idea?



********************************************************************************
***** Question 11 *****
********************************************************************************

* Save this do-file and submit it with your homework responses on Canvas

