library(MASS)
require(Matrix)
Chars<-read.table(file = "/home/chetan/Downloads/az-5000.txt",header = TRUE)
train <- sample(1:nrow(Chars), nrow(Chars)*0.8)
char.priors <- c(rep(1/26, 26))
Char.lda <- lda(char ~., Chars, subset = train, prior = char.priors)
Char.confusion <- table(Chars[-train,]$char, predict(Char.lda, Chars[-train,])$class)
print(Char.confusion)
diag(Char.confusion)<-0
Char.confusion[Char.confusion==0]<-NA

img <- image(1:26, 1:26, Char.confusion, col=c('green','blue','yellow','red'), axes=FALSE)
axis(1, at = 1:26, labels=LETTERS[1:26], las=1)
axis(2, at = 1:26, labels=LETTERS[1:26], las=1)

