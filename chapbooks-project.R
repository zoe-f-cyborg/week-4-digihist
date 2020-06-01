install.packages('tidyverse')
install.packages('tidytext')

# slightly modified version of
# https://tm4ss.github.io/docs/Tutorial_6_Topic_Models.html
# by Andreas Niekler, Gregor Wiedemann

# libraries
library(tidyverse)
library(tidytext)

# load, clean, and get data into shape

# cb = chapbooks
cb  <- read_csv("chapbooks-text.csv")

# put the data into a tibble (data structure for tidytext)
# we are also telling R what kind of data is in the 'text',
# 'line', and 'data' columns in our original csv.
# we are also stripping out all the digits from the text column

cb_df <- tibble(id = cb$line, text = (str_remove_all(cb$text, "[0-9]")), date = cb$date)

#turn cb_df into tidy format
# use `View(cb_df)` to see the difference
# from the previous table

tidy_cb <- cb_df %>%
  unnest_tokens(word, text)

# the only time filtering happens
# load up the default list of stop_words that comes
# with the tidyverse

data(stop_words)

# delete stopwords from our data
tidy_cb <- tidy_cb %>%
  anti_join(stop_words)

# this line might take a few moments to run btw
cb_words <- tidy_cb %>%
  count(id, word, sort = TRUE)

# take a look at what you've just done
# by examining the first few lines of `cb_words`

head(cb_words)

# already, you start to get a sense of what's in this dataset...

#had to include these operations before it
install.packages('tm')
library(tm)

# turn that into a matrix
dtm <- cb_words %>%
  cast_dtm(id, word, n)

install.packages('topicmodels')
require(topicmodels)
# number of topics
K <- 5
# set random number generator seed
# for purposes of reproducibility
set.seed(9161)

# compute the LDA model, inference via 1000 iterations of Gibbs sampling
topicModel <- LDA(dtm, K, method="Gibbs", control=list(iter = 500, verbose = 25))

install.packages('tm')

# have a look a some of the results (posterior distributions)
tmResult <- posterior(topicModel)

# format of the resulting object
attributes(tmResult)

# lengthOfVocab
ncol(dtm)

# topics are probability distributions over the entire vocabulary
beta <- tmResult$terms   # get beta from results
dim(beta)

# for every document we have a probability distribution of its contained topics
theta <- tmResult$topics
dim(theta)        

top5termsPerTopic <- terms(topicModel, 5)
topicNames <- apply(top5termsPerTopic, 2, paste, collapse=" ")
topicNames

# load libraries for visualization
library("reshape2")
library("ggplot2")

# select some documents for the purposes of
# sample visualizations
# here, the 2nd, 100th, and 200th document
# in our corpus

exampleIds <- c(2, 100, 200)

N <- length(exampleIds)
# get topic proportions form example documents
topicProportionExamples <- theta[exampleIds,]
colnames(topicProportionExamples) <- topicNames

# put the data into a dataframe just for our visualization
vizDataFrame <- melt(cbind(data.frame(topicProportionExamples), document = factor(1:N)), variable.name = "topic", id.vars = "document")  

# specify the geometry, aesthetics, and data for a plot
ggplot(data = vizDataFrame, aes(topic, value, fill = document), ylab = "proportion") +
  geom_bar(stat="identity") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1)) +  
  coord_flip() +
  facet_wrap(~ document, ncol = N)

#topics over time
# append decade information for aggregation
cb$decade <- paste0(substr(cb$date, 0, 3), "0")
# get mean topic proportions per decade
topic_proportion_per_decade <- aggregate(theta, by = list(decade = cb$decade), mean)
# set topic names to aggregated columns
colnames(topic_proportion_per_decade)[2:(K+1)] <- topicNames

# reshape data frame, for when I get the topics over time thing sorted
vizDataFrame <- melt(topic_proportion_per_decade, id.vars = "decade")

# plot topic proportions per deacde as bar plot
install.packages("pals")
require(pals)
ggplot(vizDataFrame, aes(x=decade, y=value, fill=variable)) +
  geom_bar(stat = "identity") + ylab("proportion") +
  scale_fill_manual(values = paste0(alphabet(20), "FF"), name = "decade") +
  theme(axis.text.x = element_text(angle = 90, hjust = 1))





