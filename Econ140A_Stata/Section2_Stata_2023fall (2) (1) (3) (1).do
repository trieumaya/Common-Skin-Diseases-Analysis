clear all
cls

***** Set your working directory *****

/*insert folder path here*/
cd "~/Desktop/ECON140A_Stata/"


********************************************************************************
***** Load and view your dataset *****

use wage.dta, clear
	

***** ask stata to do calculation 

* 1+1=?
display 1+1

* ln(12)*ln(8)
display ln(12)*ln(8)

	
	
***** probability distribution *****

* tabulation
tabulate tenure

* histogram (descrete)
histogram tenure, discrete title("Distribution of tenure")

 
 
***** compute expected value (mean) *****

* tenure
tabstat tenure, stat(mean)

* wage
tabstat wage, stat(mean)



***** show expected value line on graph *****

* discrete variable 
su tenure, d
hist tenure, discrete xline(`r(mean)') title("Distribution of tenure")

* continous variable 
su wage, d
hist wage, xline(`r(mean)') title("Distribution of wage")



***** show expected value (mean) by subgroup *****

* female vs. male
tabstat tenure if female==1, stat(mean)
tabstat tenure if female==0, stat(mean)
//alternatively
tabstat tenure, by(female) stat(mean)

* married vs. single
tabstat tenure if married==1, stat(mean)
tabstat tenure if married==0, stat(mean)
//alternatively
tabstat tenure, by(married) stat(mean)



***** show CIs of mean by subgroup *****

* female vs. male
bys female: ci means tenure

* female vs. male
bys married: ci means tenure



***** 2 ways to test whether the difference in means is statistically significant *****

* t-test 
ttest tenure, by(female)

* regression
regress tenure female
regress tenure female,robust



***** generate string based on number (to show label rather than numerber)

* female vs. male
gen Female = "Female" if female == 1
replace Female = "Male" if female == 0

* married vs. single
gen Married = "Married" if married == 1
replace Married = "Single" if married == 0



***** probability distribution for subgroup *****

* female vs. male
histogram tenure, by(Female) discrete title("Distribution of tenure")
histogram wage, by(female) density title("Distribution of wage")


* married v.s. single
histogram tenure, by(Married) discrete title("Distribution of tenure")
histogram wage, by(Married) density title("Distribution of wage")



/********************************************************************************
* INDIVIDUAL EXERCISE
*Plot the distribution of experience Males vs Females


*Plot the distribution of experience Males vs Females with a condition of single only


Plot the distribution of wage with expected value line first
Based on this result, is there an outsized density of people with above-average wage? 
What might this say about the robustness of the mean/expected value in the presence of high-performing outlier individuals? 
What might be an alternative parameter to estimate? Can you plot it instead of the expected value?

*/

