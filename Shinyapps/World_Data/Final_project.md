---
title: "Final_project"
author: "Aliya Davletshina"
date: "5/5/2019"
output: 
  html_document:
    keep_md: true
---





### World data 

The world is changing very fast, some countries experiencing unprecedented economic growth, others remaining at the same position they were 50 years ago. Today we live in a world which is more diversified then ever and the gap between the poorest and the wealthiest seems to keep growing.  The question is, should we look for the ways to reduce this gap and promote economic development in the poorest countries or should we stand aside? 
  
The first meeting of a newly established Development Assistance Group (DAG) took place in in Washington, D.C. (U.S.A.) on 9–11 March 1960. A primary concern was to keep track of the financial flows to developing countries and for that reason the term ODA (official development aid) was introduced. Now it is defined as official foreign financial aid with the main objective to promote economic development and welfare in developing countries. Throughout more than half a century data has been collected and now it is possible to look and see whether ODA is an effective measure that assists developing countries or it has little impact on the economic situation.  
  
The data used in this analysis is taken from gapminder.org and it consists of the following variables:


```
>  [1] "country"         "year"            "aid"            
>  [4] "income"          "edu_cost"        "life_exp"       
>  [7] "sanit_access"    "child_mortality" "poverty"        
> [10] "prime_school"    "health_spend"    "pop"            
> [13] "status"
```

1. aid – Aid received per person (current US\$)
Net official development assistance (ODA) per capita consists of disbursements of loans made on concessional terms (net of repayments of principal) and grants by official agencies of the members of the Development Assistance Committee (DAC), by multilateral institutions, and by non-DAC countries to promote economic development and welfare in countries and territories in the DAC list of ODA recipients; and is calculated by dividing net ODA received by the midyear population estimate. It includes loans with a grant element of at least 25 percent (calculated at a rate of discount of 10 percent).
2. income - Income per cap - GDP/capita (US$, inflation-adjusted)
Gross Domestic Product per capita in constant 2000 US\$. The inflation but not the differences in the cost of living between countries has been taken into account.
3. edu_cost - Expenditure per student, primary (% of GDP per person).
Public expenditure per student is the public current spending on education divided by the total number of students by level, as a percentage of GDP per capita. Public expenditure (current and capital) includes government spending on educational institutions (both public and private), education administration as well as subsidies for private entities (students/households and other private entities). 
4. life_exp - Life expectancy (years)
	The average number of years a newborn child would live if current mortality patterns were to stay the same.
5. sanit_access – Proportion of the population using improved sanitation facilities, total
	Access to improved sanitation facilities refers to the percentage of the population with at least adequate access to excreta disposal facilities that can effectively prevent human, animal, and insect contact with excreta. Improved facilities range from simple but protected pit latrines to flush toilets with a sewerage connection.
6. child_mortality - Child mortality (0-5 year-olds dying per 1,000 born)
	The probability that a child born in a specific year will die before reaching the age of five if subject to current age-specific mortality rates. Expressed as a rate per 1,000 live births.
7. health_spend - Total health spending (% of GDP)
8. prime_school - Primary completion rate, total (% of relevant age group)
	Primary completion rate is the percentage of students completing the last year of primary school. It is calculated by taking the total number of students in the last grade of primary school, minus the number of repeaters in that grade, divided by the total number of children of official graduation age. The ratio can exceed 100% due to over-aged and under-aged children who enter primary school late/early and/or repeat grades. 
9. poverty - Extreme poverty (% people below $1.25 a day)
	Population below 1.25 dollar a day is the percentage of the population living on less than 1.25 dollar a day at 2005 international prices. 
10. pop - Population, total
11. status - Status of a country according the level of income per capita. "Low" for under \$1,000, "lower-middle" for \$1,000-\$4,000, "upper-middle" for \$4,000-$12,000, "high" for above \$12,000.

The analysis consist of two parts. Firstly, I've taken the data for all the countried, compared the progress in different status groups by looking at how various economic indicators were changing over time and tried to find out if there is any difference in correlation between the variables among different status groups. I've also studied which status group and which particular countries have received most aid over the period of 50 years. Secondly, I've chosen 3 regions -- Latin America, West Asia and Africa to study in more detail. The main goal was to find out if there is any significant difference between the countries which received most ODA and the others.  
The link to my shiny app is [here](https://aliyaadav.shinyapps.io/Economic_development/)


<img src="Final_project_files/figure-html/unnamed-chunk-3-1.png" width="100%" style="display: block; margin: auto;" />

The chart shows that the number of high-income countries had been increasing till 1980, little changed over the next 20 years and in the beginning of the 21st century the number of low-income countries has slightly dropped. 
  
<img src="Final_project_files/figure-html/unnamed-chunk-4-1.png" width="100%" style="display: block; margin: auto;" />

The graphs show how average income per capita has changed in different status groups. There was a huge progress in high-income countries whereas income in upper-middle group has been decreasing. The other groups show fluctuations which indicates instability. Overall, we may conclude that the gap between high-income and low-income countries has increased even further. 
  
<img src="Final_project_files/figure-html/unnamed-chunk-5-1.png" width="100%" style="display: block; margin: auto;" /><img src="Final_project_files/figure-html/unnamed-chunk-5-2.png" width="100%" style="display: block; margin: auto;" />

The maps for 1960 and 2010 illustrate that little has changed in terms of the leading countries -- North America, Europe, Australia and Japan are still among the wealthiest. It is worth pointing out that the highest average income per capita has increased 5 times compared to 1960, which means that on average, we expect a country to have 5 times bigger GDP in 2010 than in 1960. 

<img src="Final_project_files/figure-html/unnamed-chunk-6-1.png" width="100%" style="display: block; margin: auto;" /><img src="Final_project_files/figure-html/unnamed-chunk-6-2.png" width="100%" style="display: block; margin: auto;" />

The maps show that the upper boundary of life expentancy has increased by 15 years while the lower boundary only by 5 years. Overall, life expentancy has increased everywhere but African countries are still falling benind.  
  
<img src="Final_project_files/figure-html/unnamed-chunk-7-1.png" width="100%" style="display: block; margin: auto;" /><img src="Final_project_files/figure-html/unnamed-chunk-7-2.png" width="100%" style="display: block; margin: auto;" /><img src="Final_project_files/figure-html/unnamed-chunk-7-3.png" width="100%" style="display: block; margin: auto;" />
  
Comparing these three matrixis it is clear that the correlation between the variables is higher in low-income countries than in other status groups. This might indicate that the more developed a country is, the more complicated is the relation between all the indicators because many other macroeconomic factors (interest rate, tax rate, exchange rate) become significant. 

<img src="Final_project_files/figure-html/unnamed-chunk-8-1.png" width="100%" style="display: block; margin: auto;" /><img src="Final_project_files/figure-html/unnamed-chunk-8-2.png" width="100%" style="display: block; margin: auto;" />

It may seem contradictory but the graphs show that most aid was received by high-income countries whereas low-income group received the least. My hypothesis is that foreign aid is given to a country with an intention to develop a new market and countries with higher income need less assistance to become potential consumer markets for the goods of a donor country.

### Data by region 



In order to find out which countries  received most aid and showed most progress, I've looked at three regions and here I start with **Latin America**. 

<img src="Final_project_files/figure-html/unnamed-chunk-10-1.png" width="100%" style="display: block; margin: auto;" />

Historically, the majority of the countries in Latin America belonged to lower-income group, but by 2011 the proportion of lower- and upper-middle income counties has almost equalized. 

<img src="Final_project_files/figure-html/unnamed-chunk-11-1.png" width="100%" style="display: block; margin: auto;" />

The graph shows how income level has changed in each country. The highest growth was in Trinidad and Tobago whereas Haiti performed the worst. But one should not forget to take into consideration a fatal earthquake of 2010 which led to hundreds of thousands dealths and had a devastating effect on Haiti's economy.  

<img src="Final_project_files/figure-html/unnamed-chunk-12-1.png" width="100%" style="display: block; margin: auto;" />

The chart shows how income per capita in each country is different from average income per capita in the region. Normally, we would expect half of the countries be on right and the other half on the left, but this chart shows a clear disproportion which means than a couple of countries produce more than a half of the GDP of the region.  

<img src="Final_project_files/figure-html/unnamed-chunk-13-1.png" width="100%" style="display: block; margin: auto;" />

In Latin America most ODA was received by low-income countries and there is a spike after the economic crisis of 2008. 
<img src="Final_project_files/figure-html/unnamed-chunk-14-1.png" width="100%" style="display: block; margin: auto;" />

Now we look at 6 countries which receved most aid and see if there is a correlation between the amount of aid received and the progress countries made. 

<img src="Final_project_files/figure-html/unnamed-chunk-15-1.png" width="100%" style="display: block; margin: auto;" />

On 6 graphs above dark blue line indicates income per capita and green shows aid per capita. The only country that seems to benefit is Belize, although it is not evident if the aid indeed had any effect on economic growth.  


<img src="Final_project_files/figure-html/unnamed-chunk-16-1.png" width="100%" style="display: block; margin: auto;" /><img src="Final_project_files/figure-html/unnamed-chunk-16-2.png" width="100%" style="display: block; margin: auto;" /><img src="Final_project_files/figure-html/unnamed-chunk-16-3.png" width="100%" style="display: block; margin: auto;" /><img src="Final_project_files/figure-html/unnamed-chunk-16-4.png" width="100%" style="display: block; margin: auto;" />

It is interesting that Bolivia, even with the least of 6 countries access to sanition, showed a most progress in terms of increased life expectancy and decreased child noratlity rate. The other thing which stroke me is a spike in child mortality rate in Honduras. After a little research it turned out there was a hurricane in 1998, and "the President of Honduras estimated that Mitch set back 50 years of economic development" of the country.[^1] [^1]:<https://en.wikipedia.org/wiki/Effects_of_Hurricane_Mitch_in_Honduras>  

  
The next region is **West Asia**. 
<img src="Final_project_files/figure-html/unnamed-chunk-17-1.png" width="100%" style="display: block; margin: auto;" />

There were no high-income countries in West Asia till 1974 -- the year then oil prices soared. Just in 6 years a quarter of the region turned to high-income countries. However, after 1990 things got worse and by 2011 there was almost equal proportion of each status group. 


<img src="Final_project_files/figure-html/unnamed-chunk-18-1.png" width="100%" style="display: block; margin: auto;" />


<img src="Final_project_files/figure-html/unnamed-chunk-19-1.png" width="100%" style="display: block; margin: auto;" />

In 2009 three main oil exporters remained the wealthiest countries in the region with Israel (which was experiencing a rapid economic growth) catching up. 

<img src="Final_project_files/figure-html/unnamed-chunk-20-1.png" width="100%" style="display: block; margin: auto;" />

The graph shows no clear pattern in ODA flows.

<img src="Final_project_files/figure-html/unnamed-chunk-21-1.png" width="100%" style="display: block; margin: auto;" />

Jordan, Israel and Bahrain each received at least twice as much as their nearest neighbours. 

<img src="Final_project_files/figure-html/unnamed-chunk-22-1.png" width="100%" style="display: block; margin: auto;" />

From the previous graph we see that Jordan received more aid than Israel but it never showed such an advancement as Israel or Oman. 

<img src="Final_project_files/figure-html/unnamed-chunk-23-1.png" width="100%" style="display: block; margin: auto;" /><img src="Final_project_files/figure-html/unnamed-chunk-23-2.png" width="100%" style="display: block; margin: auto;" /><img src="Final_project_files/figure-html/unnamed-chunk-23-3.png" width="100%" style="display: block; margin: auto;" /><img src="Final_project_files/figure-html/unnamed-chunk-23-4.png" width="100%" style="display: block; margin: auto;" />

The country that definitely stands out is Oman. Steep curves of child mortality rate and life expentancy indicate seem to indicate a considerble improve of the quality of life.  
  
  
The next region is **Africa**.

<img src="Final_project_files/figure-html/unnamed-chunk-24-1.png" width="100%" style="display: block; margin: auto;" />

The difference from other regions is rather striking. There was little change in 50 years and three fourths of the continent is still low-income countries. 

<img src="Final_project_files/figure-html/unnamed-chunk-25-1.png" width="100%" style="display: block; margin: auto;" />

Africa is the only continent where the difference among the countries is so striking: income in Zimbabwe has decreased by 32% while Equatorial Guinea showed an increase by 1254%. The rest remained almost at the same level. Such an increase in income in Equatorial Guinea was due to oil and gas exploitation which began in the 1990s.

<img src="Final_project_files/figure-html/unnamed-chunk-26-1.png" width="100%" style="display: block; margin: auto;" />

This chart is another prove of a vast diversity in the region. Jist a quarter of the continent has income above average and the rest are within one standard deviation from the mean.

<img src="Final_project_files/figure-html/unnamed-chunk-27-1.png" width="100%" style="display: block; margin: auto;" />

The graph shows that historically (from 1975) ODA was mostly to upper-income countries but it dropped for all the groups after 1996 and began to increase again in the 21st century. Probably it is linked to Millennium Development Goals set by UN in 2000. 


<img src="Final_project_files/figure-html/unnamed-chunk-28-1.png" width="100%" style="display: block; margin: auto;" /><img src="Final_project_files/figure-html/unnamed-chunk-28-2.png" width="100%" style="display: block; margin: auto;" />

The graph shows that the only country where income has increased is Botswana. In other countries like Comoros, Guinea-Bissau and Mauritania the aid practically made up a considerable part of GDP.  
<img src="Final_project_files/figure-html/unnamed-chunk-29-1.png" width="100%" style="display: block; margin: auto;" /><img src="Final_project_files/figure-html/unnamed-chunk-29-2.png" width="100%" style="display: block; margin: auto;" /><img src="Final_project_files/figure-html/unnamed-chunk-29-3.png" width="100%" style="display: block; margin: auto;" /><img src="Final_project_files/figure-html/unnamed-chunk-29-4.png" width="100%" style="display: block; margin: auto;" />

There is a high increase of health expenditures in Botswana from 1995 which resulted in increasing life expectancy in the begining of the 21st century. It turns out that the cause of poor health in the coutry in the first place was HIV/AIDS epidemics which hit Botswana in the 1990s. Even though income in the majority of the countries has not changed, nevertheless there are some signs of improvement -- lower child mortality rate and higher life expectancy. 

Overall, the data shows no direct relation between ODA and economic development in low-income countries. Further research is needed to find out the form of ODA in each particular case, find best practices of how ODA benefitted the countries and see whether the same approach could be implemented in other countries. 
