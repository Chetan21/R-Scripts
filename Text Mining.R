install.packages('tm')
library(tm)

input_data <- DirSource(directory = "/home/chetan/Downloads/Newsgroup_data", recursive = TRUE)

news.corpus<-Corpus(input_data, readerControl= list(reader=readPlain))
len = length(news.corpus)
len
temp =0
for(i in 1:len){
  if(names(news.corpus)[[i]]=="103806")
    temp = i
}
news.corpus[[temp]]
news.corpus<-tm_map(news.corpus, content_transformer(removePunctuation))
news.corpus[[temp]]
news.corpus[[temp]]$content
news.corpus<-tm_map(news.corpus, content_transformer(removeNumbers))
news.corpus[[temp]]
news.corpus[[temp]]$content
news.corpus<-tm_map(news.corpus, content_transformer(tolower))
news.corpus[[temp]]
news.corpus[[temp]]$content
news.corpus<-tm_map(news.corpus, content_transformer(removeWords), stopwords(kind="en"))
news.corpus[[temp]]
news.corpus[[temp]]$content
news.corpus<-tm_map(news.corpus, content_transformer(stripWhitespace))
news.corpus[[temp]]
news.corpus[[temp]]$content
news.corpus <- Corpus(VectorSource(news.corpus))
news.corpus
doc_mat <- DocumentTermMatrix(news.corpus, control = list(weighting = weightTfIdf, minWordLength = 1, minDocFreq = 1))
dim(doc_mat)
dict <- c('bmw', 'clutch', 'mother')
#inherits(dict, "TextDocument")
inspect(DocumentTermMatrix(news.corpus[temp], list(dictionary = dict)))
?DocumentTermMatrix
?inherits
