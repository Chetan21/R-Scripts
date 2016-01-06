az_data <- read.table("/home/chetan/Downloads/az-5000.txt", header=TRUE)
az_data <- az_data[,-1]
withArray <- c()
kmValue <- list()
for(i in 2:26){
  kmValue[[i]] <- kmeans(az_data, centers = i)
  withArray[i] <- sum(kmValue[[i]]$withinss)/i
}

withArray
plot(2:26 , withArray[2:26])
plot(15:26, withArray[15:26])
