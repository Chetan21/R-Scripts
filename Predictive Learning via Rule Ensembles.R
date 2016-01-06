install.packages('gdata')
require(gdata)
diamond_data = read.xls ("/home/chetan/Downloads/Diamond_Data.xls")
platform = "linux"
rfhome = "/home/chetan/Desktop/A4/rulefit_package"
source("/home/chetan/Desktop/A4/rulefit_package/rulefit.r")
install.packages("akima", lib=rfhome)
library(akima, lib.loc=rfhome)
categorical_vars = c('Cut', 'Color', 'Clarity', 'Polish', 'Symmetry', 'Report')
hist(as.numeric(diamond_data$Cut), main="Diamond Cut distribution", xlab = "Types of Cut", ylab ="Freq.")
hist(diamond_data$Price, main="Diamond Price distribution", xlab="Price", ylab="Freq.", labels=TRUE)
set.seed(100)
training_diamond_data <- diamond_data[sample(nrow(diamond_data), 5000), ]
rfmod = rulefit(training_diamond_data[,2:8], training_diamond_data$Price , cat.vars=categorical_vars, rfmode="regress", test.reps=10, test.fract=0.1, mod.sel=1)
rfmodinfo()
rfxval()
rules()
varimp()

test_data <- diamond_data[-sample(nrow(diamond_data), 5000), ]

actual <- test_data$Price
predicted <-rfpred(test_data[,2:8])
error <- mean(abs(actual - predicted))
error
library(rpart)
categ <- c(3, 4, 5, 6, 7, 8)
for(i in 1:ncol(training_diamond_data)){
  if(!is.na(match(i, categ))){
    training_diamond_data[,i]<- as.factor(training_diamond_data[,i])
  }
}
diamond_tree <- rpart(Price ~ ., data = training_diamond_data, method = "anova", cp=0.0001)
plotcp(diamond_tree)
minCp <- diamond_tree$cptable[minXerr, 'CP']
pruned_diamond_tree <- prune(diamond_tree, cp=minCp)
for(i in 1:ncol(test_data)){
  if(!is.na(match(i, categ))){
    test_data[,i]<- as.factor(test_data[,i])
  }
}
