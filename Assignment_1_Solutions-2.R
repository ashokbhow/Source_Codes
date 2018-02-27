# 1. Read the csv files
USDA_Micronutrients = read.csv("USDA_Micronutrients.csv")
USDA_Macronutrients = read.csv("USDA_Macronutrients.csv")

# 2. Merge the data frames using the variable "ID". Name the Merged Data Frame "USDA"
USDA = merge(USDA_Macronutrients,USDA_Micronutrients,by="ID")

# 3. Prepare the dataset for analysis
str(USDA)
USDA$Sodium = gsub(",","",USDA$Sodium, fixed = TRUE)
USDA$Sodium = as.numeric(USDA$Sodium)
USDA$Potassium = gsub(",","",USDA$Potassium, fixed = TRUE)
USDA$Potassium = as.numeric(USDA$Potassium)

# 4. Remove records with missing values in 4 or more vectors
MissingVal = rowSums(is.na(USDA))
RemoveNdx = MissingVal>4
USDAcleaning = USDA[!RemoveNdx,]

# 5. How many records remain in the data frame?
str(USDAcleaning)

# 6. For records with missing values for Sugar, Vitamin E and Vitamin D, replace missing values with mean value for the respective variable
temp=mean(USDAcleaning$Sugar,na.rm=TRUE)
c=is.na(USDAcleaning$Sugar)
USDAcleaning$Sugar[c]=temp
temp=mean(USDAcleaning$VitaminE,na.rm=TRUE)
c=is.na(USDAcleaning$VitaminE)
USDAcleaning$VitaminE[c]=temp
temp=mean(USDAcleaning$VitaminD,na.rm=TRUE)
c=is.na(USDAcleaning$VitaminD)
USDAcleaning$VitaminD[c]=temp

# 7. With a single line of code, remove all remaining records with missing values. Name the new Data Frame "USDAclean"
USDAclean=USDAcleaning[complete.cases(USDAcleaning),]

# 8. How many records remain in the data frame?
str(USDAclean)

# 9. Which food has the highest sodium level?
which.max(USDAclean$Sodium)
USDAclean$Description[262]

# 10. Create a scatter plot using Protein and Fat, with a plot title, labeling both axes, and making the data points red
plot(USDAclean$Protein, USDAclean$TotalFat, xlab="Protein", ylab = "Fat", main = "Protein vs Fat", col = "red")
dev.copy(jpeg,'ProteinFat.jpeg')
dev.off()

# 11. Create a histogram of Vitamin C distribution in foods, with a limit of 0 to 100 on the x-axis and breaks of 100
hist(USDAclean$VitaminC, xlab = "Vitamin C (mg)", main = "Histogram of Vitamin C", xlim = c(0,100), breaks=100)
dev.copy(jpeg,'histogram.jpeg')
dev.off()

# 12. Add a variable to the data frame that takes value 1 if the food has higher sodium than average, 0 otherwise
USDAclean$HighSodium = as.numeric(USDAclean$Sodium > mean(USDAclean$Sodium, na.rm=TRUE))

# 13. Do the same for High Calories, High Protein, High Sugar, and High Fat
USDAclean$HighCals = as.numeric(USDAclean$Calories > mean(USDAclean$Calories, na.rm=TRUE))
USDAclean$HighSugar = as.numeric(USDAclean$Sugar > mean(USDAclean$Sugar, na.rm=TRUE))
USDAclean$HighProtein = as.numeric(USDAclean$Protein > mean(USDAclean$Protein, na.rm=TRUE))
USDAclean$HighFat = as.numeric(USDAclean$TotalFat > mean(USDAclean$TotalFat, na.rm=TRUE))

# 14. How many foods have both high sodium and high fat?
table(USDAclean$HighSodium, USDAclean$HighFat)

# 15. Calculate the average amount of iron, sorted by high and low protein
tapply(USDAclean$Iron, USDAclean$HighProtein, mean, na.rm=TRUE)


