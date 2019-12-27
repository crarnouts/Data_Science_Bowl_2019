### Re-Engineer the Target Variable


## Library

library(tidyverse)
library(dplyr)

## Load in all of the data

sample_submission <- read.csv("C:/Users/carnout/OneDrive - Farm Bureau Life Insurance Company of Michigan/Data-Science-Bowl/sample_submission.csv")

specs <- read.csv("C:/Users/carnout/OneDrive - Farm Bureau Life Insurance Company of Michigan/Data-Science-Bowl/specs.csv")

test <- read.csv("C:/Users/carnout/OneDrive - Farm Bureau Life Insurance Company of Michigan/Data-Science-Bowl/test.csv",nrows=1000000)

train <- read.csv("C:/Users/carnout/OneDrive - Farm Bureau Life Insurance Company of Michigan/Data-Science-Bowl/train.csv",nrows=1000000)

train_labels <- read.csv("C:/Users/carnout/OneDrive - Farm Bureau Life Insurance Company of Michigan/Data-Science-Bowl/train_labels.csv")

## read in the re-labelled eventids and event codes
event_id_codes_labelled <- read.csv("C:/Users/carnout/OneDrive - Farm Bureau Life Insurance Company of Michigan/Data-Science-Bowl/event_codes_labeled.csv",nrows=100000)


train_labels$total_attempts <- train_labels$num_correct + train_labels$num_incorrect

train_labels$correct_ratio <- train_labels$num_correct/train_labels$total_attempts

# Remove useless words from the user actions

stopwords = c("This event occurs when the","event occurs when the")

specs$info2 <- gsub(paste0(stopwords,collapse = "|"),"", specs$info)

## take a look at the user action descriptions
#specs %>% select(info2) %>% View()


## how many different games are there
unique(train$title)

#different event codes, this are high level actions like starting an activity but some are unique to the specific game
unique(train$event_code)


## need to figure out a way to match some of the event codes to what they actually signify 
## example 2000 is the start of a game
### Match up Event codes with info

train2 <- train %>% select(installation_id,game_session,event_id,event_code,event_data,title)
specs2 <- specs %>% select(event_id,info2,args)

train3 <- merge(train2,specs2)
  
#look at the event codes

#train3 %>% distinct(event_id,info2,event_code) %>% View()


############## do some labeling of event_codes
# event_code_labels <- train3 %>% distinct(event_id,info2,event_code)
# 
# labels <-event_id_codes_labelled %>% select(event_id,Action)
# 
# event_code_labels <- left_join(event_code_labels,labels)
# 
# write.csv(event_code_labels, file ="C:/Users/carnout/OneDrive - Farm Bureau Life Insurance Company of Michigan/Data-Science-Bowl/event_code_labels.csv")
#   
#################### also don't forget to show the journey from one activity to another and what this means for their global accuracy_group




