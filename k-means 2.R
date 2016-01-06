az_da <- read.table("/home/chetan/Downloads/az-5000.txt", header=TRUE)
az_data <- az_da[,-1]
withArray <- c()
kmValue <- list()
for(i in 2:26){
  kmValue[[i]] <- kmeans(az_data, centers = i)
  withArray[i] <- sum(kmValue[[i]]$withinss)/i
}

distance <- dist(kmValue[[26]]$centers, method="euclidean")
hclust_dendo <- hclust(distance, method="average")
plot(hclust_dendo)
letter_mat <- table(kmValue[[26]]$cluster, az_da$char)
letter_mat

set_letters <- letters[apply(letter_mat, 1, which.max)]
rownames(kmValue[[26]]$centers) <- set_letters
new_distance <- dist(kmValue[[26]]$centers, method="euclidean")
new_hclust_dendo <- hclust(new_distance, "average")
plot(new_hclust_dendo)

?hclust
