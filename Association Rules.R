install.packages('arules')
library(arules)
movies_data <- read.transactions("/home/chetan/Downloads/ratingsAsBasket.txt", format = "basket")
summary(movies_data)
asso_rules <- apriori(movies_data)
?inspect
inspect(sort(asso_rules[1:10]))
subset(asso_rules, lift>3)
