## LSE Data Analytics Online Career Accelerator 

# DA301:  Advanced Analytics for Organisational Impact

###############################################################################

# Assignment template

## Scenario
## You are a data analyst working for Turtle Games, a game manufacturer and 
## retailer. They manufacture and sell their own products, along with sourcing
## and selling products manufactured by other companies. Their product range 
## includes books, board games, video games and toys. They have a global 
## customer base and have a business objective of improving overall sales 
##performance by utilising customer trends. 

## In particular, Turtle Games wants to understand:
## - how customers accumulate loyalty points (Week 1)
## - how useful are remuneration and spending scores data (Week 2)
## - can social data (e.g. customer reviews) be used in marketing 
##     campaigns (Week 3)
## - what is the impact on sales per product (Week 4)
## - the reliability of the data (e.g. normal distribution, Skewness, Kurtosis)
##     (Week 5)
## - if there is any possible relationship(s) in sales between North America,
##     Europe, and global sales (Week 6).

################################################################################

# Week 4 assignment: EDA using R

## The sales department of Turtle games prefers R to Python. As you can perform
## data analysis in R, you will explore and prepare the data set for analysis by
## utilising basic statistics and plots. Note that you will use this data set 
## in future modules as well and it is, therefore, strongly encouraged to first
## clean the data as per provided guidelines and then save a copy of the clean 
## data for future use.

# Instructions
# 1. Load and explore the data.
##  - Remove redundant columns (Ranking, Year, Genre, Publisher) by creating 
##      a subset of the data frame.
##  - Create a summary of the new data frame.
# 2. Create plots to review and determine insights into data set.
##  - Create scatterplots, histograms and boxplots to gain insights into
##      the Sales data.
##  - Note your observations and diagrams that could be used to provide
##      insights to the business.
# 3. Include your insights and observations.

###############################################################################

# 1. Load and explore the data

# Install and import Tidyverse.
library(tidyverse)

# Import the data set.
data <- read.csv(file.choose())
as_tibble(data)

# Print the data frame.
data
View(data)

# Create a new data frame from a subset of the sales data frame.
# Remove unnecessary columns. 
data <- subset(data, select = -c(Ranking, Year, Genre, Publisher))

# View the data frame.
View(data)


# View the descriptive statistics.
summary(data)

################################################################################

# 2. Review plots to determine insights into the data set.

## 2a) Scatterplots
# Create scatterplots.
qplot(y=NA_Sales, data=data)
qplot(y=EU_Sales, data=data)
qplot(y=Global_Sales, data=data)


## 2b) Histograms
# Create histograms.
qplot(NA_Sales, data=data)
qplot(EU_Sales, data=data)
qplot(Global_Sales, data=data)

## 2c) Boxplots
# Create boxplots.
qplot(NA_Sales, Platform, data=data, geom='boxplot')
qplot(EU_Sales, Platform, data=data, geom='boxplot')
qplot(Global_Sales, Platform, data=data, geom='boxplot')


###############################################################################

# 3. Observations and insights

## Your observations and insights here ......

## North America Sales
# Most games make 0-10 million pounds. 
# One games make more than 30 million punds.

## EU Sales
# All games make 0-11 million pounds, 
# with one exception that meks more than 20 million pounds.

##Global Sales
# Most games make 0-20 million pounds. 
# One game makes more than 60 million pounds.


###############################################################################
###############################################################################


# Week 5 assignment: Cleaning and maniulating data using R

## Utilising R, you will explore, prepare and explain the normality of the data
## set based on plots, Skewness, Kurtosis, and a Shapiro-Wilk test. Note that
## you will use this data set in future modules as well and it is, therefore, 
## strongly encouraged to first clean the data as per provided guidelines and 
## then save a copy of the clean data for future use.

## Instructions
# 1. Load and explore the data.
##  - Continue to use the data frame that you prepared in the Week 4 assignment. 
##  - View the data frame to sense-check the data set.
##  - Determine the `min`, `max` and `mean` values of all the sales data.
##  - Create a summary of the data frame.
# 2. Determine the impact on sales per product_id.
##  - Use the group_by and aggregate functions to sum the values grouped by
##      product.
##  - Create a summary of the new data frame.
# 3. Create plots to review and determine insights into the data set.
##  - Create scatterplots, histograms, and boxplots to gain insights into 
##     the Sales data.
##  - Note your observations and diagrams that could be used to provide 
##     insights to the business.
# 4. Determine the normality of the data set.
##  - Create and explore Q-Q plots for all sales data.
##  - Perform a Shapiro-Wilk test on all the sales data.
##  - Determine the Skewness and Kurtosis of all the sales data.
##  - Determine if there is any correlation between the sales data columns.
# 5. Create plots to gain insights into the sales data.
##  - Compare all the sales data (columns) for any correlation(s).
##  - Add a trend line to the plots for ease of interpretation.
# 6. Include your insights and observations.

################################################################################

# 1. Load and explore the data

# View data frame created in Week 4.
View(data)


# Check output: Determine the min, max, and mean values.
# Min
min_sales <- apply(data[3:5], 2, min)
min_sales

# Max
max_sales <- apply(data[3:5], 2, max)
max_sales

# Mean
mean_sales <- apply(data[3:5], 2, mean)
mean_sales

###############################################################################

# 2. Determine the impact on sales per product_id.

## 2a) Use the group_by and aggregate functions.
# Group data based on Product and determine the sum per Product.
sales_pp <- aggregate(cbind(NA_Sales,EU_Sales,Global_Sales)~ Product,
                      data=data, FUN=sum)

# View the data frame.
View(sales_pp)

# Explore the data frame.
summary(sales_pp)


## 2b) Determine which plot is the best to compare game sales.
# Create scatterplots.
# NA
ggplot (data=sales_pp, 
         mapping=aes(x=Product, 
                     y=NA_Sales)) +
  
  geom_point(color='green',
             alpha = 0.5,
             size = 1.5)+
geom_smooth(method = 'lm')

# EU
ggplot (data=sales_pp, 
        mapping=aes(x=Product, y=EU_Sales)) +
  
  geom_point(color='red',
             alpha = 0.5,
             size = 1.5)+
  geom_smooth(method = 'lm')

#Global
ggplot (data=sales_pp, 
        mapping=aes(x=Product, y=Global_Sales)) +
  
  geom_point(color='blue',
             alpha = 0.5,
             size = 1.5)+
geom_smooth(method = 'lm')


# Create histograms.
hist(sales_pp$NA_Sales)
hist(sales_pp$EU_Sales)
hist(sales_pp$Global_Sales)

# Create boxplots.
# NA
ggplot(sales_pp, aes(x=Product,
                     y=NA_Sales)) +
  geom_boxplot()

# EU
ggplot(sales_pp, aes(x=Product,
                     y=EU_Sales)) +
  geom_boxplot()

# Global
ggplot(sales_pp, aes(x=Product,
                     y=Global_Sales)) +
  geom_boxplot()


###############################################################################


# 3. Determine the normality of the data set.

## 3a) Create Q-Q Plots
# Create Q-Q Plots.
qqnorm(sales_pp$NA_Sales)
qqline(sales_pp$NA_Sales)

qqnorm(sales_pp$EU_Sales)
qqline(sales_pp$EU_Sales)

qqnorm(sales_pp$Global_Sales)
qqline(sales_pp$Global_Sales)


## 3b) Perform Shapiro-Wilk test
# Install and import Moments.
install.packages("moments")
library(moments)

# Perform Shapiro-Wilk test.
shapiro.test(sales_pp$NA_Sales)
shapiro.test(sales_pp$EU_Sales)
shapiro.test(sales_pp$Global_Sales)

## 3c) Determine Skewness and Kurtosis
# Skewness and Kurtosis.
skewness(sales_pp$NA_Sales)
skewness(sales_pp$EU_Sales)
skewness(sales_pp$Global_Sales)

kurtosis(sales_pp$NA_Sales)
kurtosis(sales_pp$EU_Sales)
kurtosis(sales_pp$Global_Sales)

## 3d) Determine correlation
# Determine correlation.
# NA
cor(sales_pp$NA_Sales, sales_pp$EU_Sales)
cor(sales_pp$NA_Sales, sales_pp$Global_Sales)
cor(sales_pp$Global_Sales, sales_pp$EU_Sales)

round(cor(sales_pp), digits=2)

###############################################################################

# 4. Plot the data
# Create plots to gain insights into data.
# Choose the type of plot you think best suits the data set and what you want 
# to investigate. Explain your answer in your report.
ggplot (data=sales_pp, 
        mapping=aes(x=Product, y=Global_Sales)) +
  
  geom_point(color='blue',
             alpha = 0.5,
             size = 1.5)+
  geom_smooth(method = 'lm')

# I choose the scatter plot to be the best
# type of the three plots. This is because 
# histrogram can only show the distribtion 
# of one variable. In this case, we also 
# want to see the relations hip of sales with
# the product ID number. The boxplot is not suitable
# because there are too many product numbers to be displayed.

###############################################################################

# 5. Observations and insights
# Your observations and insights here...
# The sales number in each region positively affect each other. 
# The means that is a number of sales in one region increases, 
# the number in other regions will increase as well.



###############################################################################
###############################################################################

# Week 6 assignment: Making recommendations to the business using R

## The sales department wants to better understand if there is any relationship
## between North America, Europe, and global sales. Therefore, you need to
## investigate any possible relationship(s) in the sales data by creating a 
## simple and multiple linear regression model. Based on the models and your
## previous analysis (Weeks 1-5), you will then provide recommendations to 
## Turtle Games based on:
##   - Do you have confidence in the models based on goodness of fit and
##        accuracy of predictions?
##   - What would your suggestions and recommendations be to the business?
##   - If needed, how would you improve the model(s)?
##   - Explain your answers.

# Instructions
# 1. Load and explore the data.
##  - Continue to use the data frame that you prepared in the Week 5 assignment. 
# 2. Create a simple linear regression model.
##  - Determine the correlation between the sales columns.
##  - View the output.
##  - Create plots to view the linear regression.
# 3. Create a multiple linear regression model
##  - Select only the numeric columns.
##  - Determine the correlation between the sales columns.
##  - View the output.
# 4. Predict global sales based on provided values. Compare your prediction to
#      the observed value(s).
##  - NA_Sales_sum of 34.02 and EU_Sales_sum of 23.80.
##  - NA_Sales_sum of 3.93 and EU_Sales_sum of 1.56.
##  - NA_Sales_sum of 2.73 and EU_Sales_sum of 0.65.
##  - NA_Sales_sum of 2.26 and EU_Sales_sum of 0.97.
##  - NA_Sales_sum of 22.08 and EU_Sales_sum of 0.52.
# 5. Include your insights and observations.

###############################################################################

# 1. Load and explor the data
# View data frame created in Week 5.
View(sales_pp)

# Determine a summary of the data frame.
summary(sales_pp)

###############################################################################

# 2. Create a simple linear regression model
## 2a) Determine the correlation between columns
# Create a linear regression model on the original data.
NA_EU_m <- lm(NA_Sales~EU_Sales, data=sales_pp)
NA_EU_m
summary(NA_EU_m)

NA_G_m <- lm(NA_Sales~Global_Sales, data=sales_pp)
NA_G_m
summary(NA_G_m)

EU_G_m <- lm(EU_Sales~Global_Sales, data=sales_pp)
EU_G_m
summary(EU_G_m)

plot(sales_pp$EU_Sales, sales_pp$NA_Sales)
plot(sales_pp$Global_Sales, sales_pp$NA_Sales)
plot(sales_pp$Global_Sales, sales_pp$EU_Sales)
## 2b) Create a plot (simple linear regression)
# Basic visualisation.
abline(coefficients(NA_EU_m))
abline(coefficients(NA_G_m))
abline(coefficients(EU_G_m))
###############################################################################

# 3. Create a multiple linear regression model
# Select only numeric columns from the original data frame.
# Multiple linear regression model.

NA_mm = lm(NA_Sales~EU_Sales+Global_Sales, data=sales_pp)
summary(NA_mm)

EU_mm = lm(EU_Sales~NA_Sales+Global_Sales, data=sales_pp)
summary(EU_mm)

Global_mm = lm(Global_Sales~NA_Sales+EU_Sales, data=sales_pp)
summary(Global_mm)


###############################################################################

# 4. Predictions based on given values
# Compare with observed values for a number of records.



# Create a new object and specify the predict function.
predictTest_Global = predict(Global_mm, newdata=sales_pp,
                      interval='confidence')
predictTest_Global 

# Global sales = 1.04242 + 1.13040(NA) + 1.19992(EU)

#NA_Sales_sum of 34.02 and EU_Sales_sum of 23.80 > Global_Sales = 68.06
# Original data set > 67.85

#NA_Sales_sum of 3.93 and EU_Sales_sum of 1.56 > Global_Sales = 7.36
# Original data set > 6.04

#NA_Sales_sum of 2.73 and EU_Sales_sum of 0.65 > Global_Sales = 4.90836
# Original data set > 4.32

#NA_Sales_sum of 2.26 and EU_Sales_sum of 0.97 > Global_Sales = 4.7610464
# Original data set > 3.53

#NA_Sales_sum of 22.08 and EU_Sales_sum of 0.52 > Global_Sales = 26.6256104
# Original data set > 23.21

###############################################################################

# 5. Observations and insights
# Your observations and insights here...
# Global sales is positively related to NA sales and EU sales. 
# This is means that if the NA sales or EU sales go up, the 
# global sales will go up as well.


###############################################################################
###############################################################################




