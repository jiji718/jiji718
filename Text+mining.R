# Text Mining
#Install
#install.packages("tm")  # for text mining
#install.packages("SnowballC") # for text stemming
#install.packages("wordcloud") # word-cloud generator 
#install.packages("RColorBrewer") # color palettes
#install.packages("syuzhet") # for sentiment analysis
#install.packages("ggplot2") # for plotting graphs
# Load
library(tm)
library(SnowballC)
library(wordcloud)
library(RColorBrewer)
library(syuzhet)
library(ggplot2)
library(jsonlite)

# Reading File
rtxt_file <- "depot/tdm-ff/data/renttherunway_final_data.json"
rtxt <- fromJSON(sprintf("[%s]", paste(readLines(rtxt_file), collapse=",")))

# Organizing columnsr
print(summary(rtxt))

# Selecting Columns
rtxt_data <- rtxt[, c( "rating","review_text","review_summary", "review_date")]
rtxt_data$rating <- as.numeric(rtxt_data$rating)

# dividing date
library(stringr)
library(dplyr)
#install.packages("dplyr")
#install.packages("tidyverse")
library(word2vec)
library(tidyverse)

rtxt_data$review_text
rtxt_data$review_summary
rtxt_data$review_date

library(splitstackshape)
rdate <- str_split(rtxt_data$review_date, " ", simplify = TRUE) 
rtxt_data <- cbind(rtxt_data, rdate[,3])
rtxt_data <- rtxt_data[-4]
rtxt_data <- rtxt_data[-5]
head(rtxt_data)

rtxt_data$`...5` <- as.numerics(rtxt_data$`...5`)
colnames(rtxt_data$`...5`) <- c("review_date")
summary(rtxt_data)

rtxt <- as.matrix(rtxt)
head(rtxt_data)
summary(rtxt_data)




rxtx_data <- Corpus(VectorSource(rtxt_data$))
library(stringr)

# Replacing "/", "@" and "|" with space
toSpace <- content_transformer(function (x , pattern ) gsub(pattern, " ", x))
rtxt_data <- tm_map(rtxt_data, toSpace, "/")
rtxt_data <- tm_map(rtxt_data, toSpace, "@")
rtxt_data <- tm_map(rtxt_data, toSpace, "\\|")
rtxt_data <- tm_map(rtxt_data, toSpace, "?")

# Convert the text to lower case
rtxt_data <- str_to_lower(string, locale = "en")
# Remove numbers
rtxt_data <- removeNumbers(rtxt_data)
# Remove english common stopwords
rtxt_data <- tm_map(rtxt_data, removeWords, stopwords("english"))
# Remove punctuations
rtxt_data <- tm_map(rtxt_data, removePunctuation)
# Eliminate extra white spaces
rtxt_data <- tm_map(rtxt_data, stripWhitespace)
# Text stemming - which reduces words to their root form
rtxt_data <- tm_map(rtxt_data, stemDocument)
