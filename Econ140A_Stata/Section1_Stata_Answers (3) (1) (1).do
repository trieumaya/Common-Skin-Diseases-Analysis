clear all
cls

***** Set your working directory *****

/*insert folder path here*/
cd Desktop/Econ140A_Stata

********************************************************************************
***** Load and view your dataset *****

use Earnings_and_Height.dta, clear
	
* Take a look at the data
describe
browse 


********************************************************************************
***** Tabulate Strings and Create Summary Tables *****

* Quick Statistic
tabstat earnings, stat(mean)

* Simple summary of continuous variables
summarize earnings height weight

* Detailed summary of continuous variable
summarize earnings, detail

* Fun thing about Stata: shortcuts
su height, d

* Simple one-way table for categorical variable
tabulate sex

* Find out how many categories there are
quietly tabulate sex
dis r(r)

* Simple two-way table for categorical variables
tabulate sex relationship

* Simple two-way table continuous AND categorical variables
tabulate relationship, summarize(earnings)


********************************************************************************
***** Boolean Expressions and Subsetting *****

* Analyze Subsets from Single Conditions
summarize earnings if (height > 60)
summarize earnings if (height < 60)
summarize earnings if (height == 60)

summarize weight if sex == "Male"
summarize weight if sex != "Male"

tabstat earnings, by(educ) stat(mean)

* Analyze Subsets from Multiple conditions
tabulate region if (earnings < 20000) & (relationship == "Single")
tabulate race if (educ > 12) | (earnings > 80000)
summarize weight if (educ < 12) | (earnings < 20000)


********************************************************************************
***** Creating new variables: "gen var = exp()" *****

* Creating Dummy Variables from String Variables
tabulate sex 
gen indicator_female = (sex == "Female")
summarize indicator_female

* Creating Dummy Variables from Continuous Variables
gen indicator_high_earner = (earnings >= 80000)
gen indicator_high_earner_minority = (earnings >= 80000) & (race != "White")
summarize indicator_high_earner indicator_high_earner_minority

* Transforming Variables
gen log_weight = log(1 + weight)
gen earnings_squared = (earnings)^2
gen height_in_centimeters = 2.54 * height

* Using egen to compute totals and averages
egen mean_earnings = mean(earnings)
egen total_earnings = total(earnings)


********************************************************************************
***** Visualize Relationships *****

* Scatter Plots
scatter earnings educ, title("Earnings vs Education Graph")
scatter earnings educ, by(sex) title("Earnings vs Education by Sex Graph")

* Histograms
histogram weight, title("Distribution of Weights")
histogram weight if (weight < 300), title("Distribution of Weights (<300 lbs)")

********************************************************************************
* INDIVIDUAL EXERCISE

* Compare average earnings for males vs females
tabstat earnings, by(sex)

* Compare average earnings for single vs married people
tabstat earnings, by(relationship)

* Who has a larger variance in earnings? Single Males, or Married Females?
summarize earnings if sex == "Male" & relationship == "Single", detail 
summarize earnings if sex == "Female" & relationship == "Married", detail 

* Plot the relationship between Earnings and Height for Males vs Females
*hint: scatter plot <exp>, by(<condition>)
scatter earnings height, by(sex)

* Do the same as above, but now add a condition to only include married people
scatter earnings heigh if relationship == "Married", by(sex)

* Use egen to create a variable avg_earnings that the avg earnings of the sample
egen avg_earnings = mean(earnings)

* Create new_var that is: earnings minus avg_earnings raised to 3rd power
gen new_var = (earnings - avg_earnings) ^ 3

* Keep only observations of males (hint: use "keep if <exp>")
keep if sex == "Male"

* Create Indicator for Male and Married and find out what % are married males
gen indicator_married_male = (sex == "Male") & relationship == "Married"

* Plot Earnings vs Weight for Married and Single Men side-by-side
scatter earnings weight, by(indicator_married_male) 

* Graph the distribution of heights for single men who earn less than $20k
histogram height if indicator_married_male == 0 & earnings < 20000

* Tabulate the Race of Married Men who make greater than $80k
tabulate race if indicator_married_male == 1 & earnings > 80000

/* Create a new variable called "earnings_in_thousands" that expresses each
individual's earnings in terms of thousands of dollars */
gen earnings_in_thousands = earnings / 1000
