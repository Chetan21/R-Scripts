install.packages('recommenderlab')
ratings_data <-scan("/home/chetan/Downloads/ratings.txt", what = 'list', sep='|')
library(Matrix)

class(ratings_data) <- "numeric"
ratings_data <- matrix(ratings_data, ncol=3, byrow = TRUE)

ratings_mat <-sparseMatrix(i=ratings_data[,1], j=ratings_data[,2], x=ratings_data[,3])
#ratings_mat[1:5,1:5]
dimnames(ratings_mat) <- list(user=paste("U", 1:10000), Movie=paste("M", 1:7223))
dim(ratings_mat)

require(recommenderlab)

rat_mat <- new("realRatingMatrix", data=ratings_mat)
set.seed(50)
training_rating_data <- rat_mat[sample(nrow(rat_mat), nrow(rat_mat)*0.8), ]

reco <- Recommender(training_rating_data, method="UBCF")
results <- predict(reco, training_rating_data[1000], method = "UBCF", n=5)

as(results, "list")
results <- predict(reco, training_rating_data[500], method = "UBCF", n=1)
