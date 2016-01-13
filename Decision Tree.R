#http://www.statmethods.net/advstats/cart.html
houseType = read.csv("housetype_data.csv")
attach(houseType)

#Factoring the categorical values
houseType[,"sex"] = as.factor(houseType[,"sex"])
houseType[,"ms"] = as.factor(houseType[,"ms"])
houseType[,"ocu"] = as.factor(houseType[,"ocu"])
houseType[,"di"] = as.factor(houseType[,"di"])
houseType[,"hhs"] = as.factor(houseType[,"hhs"])
houseType[,"eth"] = as.factor(houseType[,"eth"])
houseType[,"lang"] = as.factor(houseType[,"lang"])

set.seed(55)
ind = sample(nrow(houseType), 0.9*nrow(houseType))
train_data = houseType[ind,]
test_data = houseType[-ind,]

#Number of NAs in the data set = 2671
sum(is.na(houseType))

library(rpart)
#treefit = rpart(ht ~., data=train_data, method="class", control = rpart.control(cp=0.0001))
treefit = rpart(ht ~ sex+ms+age+edu+ocu+inc+ba+di+hs+hs2+hhs+eth+lang, data=train_data, 
                method="class", control = rpart.control(cp=0.0001))

printcp(treefit)
plotcp(treefit)
#Row with minimum CV error (xerror) : 
#Tree     CP         nsplit  rel error    error   xstd
#12   0.00060368      29      0.60368   0.63356 0.011906
min_cp = treefit$cptable[which.min(treefit$cptable[,"xerror"]),"CP"]

#ptree = prune(treefit, cp = treefit$cptable[which.min(treefit$cptable[,"xerror"]),"CP"])
ptree = prune(treefit, cp = min_cp)
plot(ptree, uniform=TRUE, main="Pruned Classification Tree for HouseType", margin=0.1)
text(ptree, all=TRUE, cex=.7, pretty=0)

conf_mat = table(test_data$ht, predict(ptree,test_data, type="class"))
accuracy = sum(diag(conf_mat))/sum(conf_mat)
#test accuracy = 71.2%