# Natalie Priebe
# 2018.06.28
# Course: System Simulation
# Text Mining - Presidential Election 2016: Trump Vs. Clinton
# Part I: Donald Trump

# Installation of required packages
install.packages("tm")  # text mining
install.packages("wordcloud") # generator for wordcloud
install.packages("RColorBrewer") # color palettes

# Load the required packages
library("tm") # text mining
library("wordcloud") # wordcloud
library("RColorBrewer") # color palettes

# Read the text and save it in 'trump'
# Source: http://time.com/3923128/donald-trump-announcement-speech/ (accessed: 28.06.2018)
trump <- readLines("Trump_Speech.txt")

# Load the text as a corpus and save it in 'docs'
docs <- Corpus(VectorSource(trump))

# Transformation of the text:
# Converting the text to lower case
docs <- tm_map(docs, content_transformer(tolower))
# Removing all numbers
docs <- tm_map(docs, removeNumbers)
# Removing english common stopwords
docs <- tm_map(docs, removeWords, stopwords("english"))
# Removing punctuations
docs <- tm_map(docs, removePunctuation)
# Removing all extra white spaces
docs <- tm_map(docs, stripWhitespace)

# Build a term-document matrix (The matrix contains the frequency of the words.)
dtm <- TermDocumentMatrix(docs)
m <- as.matrix(dtm)
v <- sort(rowSums(m),decreasing=TRUE)
d <- data.frame(word = names(v),freq=v)
# Displays the 20 most frequent words in the console for checking
head(d, 20)

# Generate the wordcloud with frequency of min. 2 and max. 200 words
wordcloud(words = d$word, freq = d$freq, min.freq = 2,
          max.words=200, random.order=FALSE, rot.per=0.35, 
          colors=brewer.pal(6,"Paired"))

# Plott the histogram of the 20 most frequent words
barplot(d[1:20,]$freq, las = 2, names.arg = d[1:20,]$word,
        col ="blue", main ="Presidential Election 2016: Most frequent words of Donald Trumps Speech",
        ylab = "word frequencies")

# Clear workspace
rm(list = ls())