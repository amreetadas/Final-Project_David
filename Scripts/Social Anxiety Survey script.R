library(readr)
library(tidyverse)
library(skimr)
library(visdat)
library(plotly)
knitr::opts_chunk$set(echo = TRUE)


#' # This project is using the Social Anxiety Survey from https://www.kaggle.com/datasets/carlsonhoo/university-social-anxiety-survey/data
#'
#' Download the data from the website, or the data should be included in the github repository.
#'  

#'  If you have your pathway set this is an way to load in the csv file.
#'  I also renamed the set to data_fr to make it easier to work with. 
#'  reviewer comment: setting a path would be useful. Using here::here() like we have in the class is a good option.

path <- here::here() 
data_fr <- read_csv(paste0(path, "/Data/Social_Anxiety_Survey_Master.csv")) ## edited by reviewer to make line work
data_fr <- read_csv("Social_Anxiety_Survey_Master.csv") 
#' This gives an overview of the data
skim(data_fr) 

#' This gives the distribution of answers for each question. 66 Respondents in total. 42 Student Respondents
#' This filters out the non-students and gives me the number of responses by age group. 
filter(data_fr, Student == 'Yes') |> count(Age)
# 29/42 = 69% of students were ages 21 - 30
# 7/42 = 17% of students were ages 31 - 40
# 6/42 = 14% of students were 20 or below
#' Q1 is ("How many hours per day do you spend on social media?")
#'  
#' Q2 is ("How do you feel being the center of attention")
#' 
#' Q3 is ("Working while being observed?")
#' 
#' Q4 is ("Talking face to face with someone you don't know very well?")
#' 
#' Q5 is ("Expressing disagreement or disapproval to someone you don't know very well")
#' 
#' Q6 is ("Are you extremely conscious of your actions when in social settings because you fear they might offend someone or you could be rejected?")
#' 
#' Q7 is ("Do you feel anxious or panicky before social situations?")
#' 
#' The count lets me see the distribution of answers for each column. 
#' Some questions were multiple choice while others are based off 1-5 of the Likert scale. 
count(data_fr, Q1) 
count(data_fr, Q2)
count(data_fr, Q3)
count(data_fr, Q4)
count(data_fr, Q5)
count(data_fr, Q6)
count(data_fr, Q7)

#I decided having the columns listed as Q would be easier and have the columns names listed as comments rather than replacing their names in the dataframe. 

#' This gives length, class, and mode for a chosen column. 
summary(data_fr$Q1)

#' This checks if all questions were answered for each subject , which shows 100% on all questions. 
data_fr %>%
  select(Student, Age, Q1, Q2, Q3, Q4, Q5, Q6, Q7) %>%
  vis_miss(cluster = TRUE) 

#' This checks the beginning and end of the data. Doesn't appear to have any errors or discrepancies. 
data_fr |>
  head () |>
  view()

data_fr |>
  tail () |>
  view()

#' Compared with at least one external source. There is a discrepancy from the data mentioned from the blog and what is available on kaggle.  
#' https://carlson-hoo.medium.com/what-type-of-social-media-users-are-more-likely-to-have-social-anxiety-disorder-65194323f8e1
#' 
#' I cannot find a record as to why there are 42 students available on kaggle but 69 students listed on the blog website. 
#' Perhaps the author received more data after he uploaded the set to kaggle and before the blogsite was created. 
#'
#' This visualizes the distribution of answers for each question and removes the non-student answers.   
data_fr |>
  filter(Student == "Yes") |>
ggplot(aes(Q1)) +
  geom_bar()

data_fr |>
  filter(Student == "Yes") |>
  ggplot(aes(Q2)) +
  geom_bar()

data_fr |>
  filter(Student == "Yes") |>
  ggplot(aes(Q3)) +
  geom_bar()

data_fr |>
  filter(Student == "Yes") |>
  ggplot(aes(Q4)) +
  geom_bar()

data_fr |>
  filter(Student == "Yes") |>
  ggplot(aes(Q5)) +
  geom_bar()

data_fr |>
  filter(Student == "Yes") |>
  ggplot(aes(Q6)) +
  geom_bar()

data_fr |>
  filter(Student == "Yes") |>
  ggplot(aes(Q7)) +
  geom_bar()

#' This section creates colored graphs comparing variables of interest. 
data_fr |>
  filter(Student == "Yes") |>
  ggplot(aes(Q1, fill = Gender)) +
  geom_bar(position = position_fill()) +
  scale_fill_manual(values = c('red', 'blue', 'green', 'black', 'purple'))

data_fr |>
  filter(Student == "Yes") |>
  ggplot(aes(Gender, fill = as.factor(Q2))) +
  geom_bar(position = position_fill()) +
  scale_fill_manual(values = c('red', 'blue', 'green', 'black', 'purple'))
data_fr |>
  filter(Student == "Yes") |>
  ggplot(aes(Gender, fill = as.factor(Q3))) +
  geom_bar(position = position_fill()) +
  scale_fill_manual(values = c('red', 'blue', 'green', 'black', 'purple'))
data_fr |>
  filter(Student == "Yes") |>
  ggplot(aes(Gender, fill = as.factor(Q4))) +
  geom_bar(position = position_fill()) +
  scale_fill_manual(values = c('red', 'blue', 'green', 'black', 'purple'))
data_fr |>
  filter(Student == "Yes") |>
  ggplot(aes(Gender, fill = as.factor(Q5))) +
  geom_bar(position = position_fill()) +
  scale_fill_manual(values = c('red', 'blue', 'green', 'black', 'purple'))
data_fr |>
  filter(Student == "Yes") |>
  ggplot(aes(Gender, fill = as.factor(Q6))) +
  geom_bar(position = position_fill()) +
  scale_fill_manual(values = c('red', 'blue', 'green', 'black', 'purple'))
data_fr |>
  filter(Student == "Yes") |>
  ggplot(aes(Gender, fill = as.factor(Q7))) +
  geom_bar(position = position_fill()) +
  scale_fill_manual(values = c('red', 'blue', 'green', 'black', 'purple'))
#' This section shows the percentages of answers between genders for each question in descending order of most stressed to least stressed. 
data_fr |> 
  filter(Student == "Yes") |>
  count(Gender, Q1) |>
  group_by(Gender) |>
  mutate(share = n / sum(n)) |>
  ungroup()|>
  arrange(desc(Q1))|>
  mutate(share = scales::percent(share, accuracty = 1))
data_fr |> 
  filter(Student == "Yes") |>
  count(Gender, Q2) |>
  group_by(Gender) |>
  mutate(share = n / sum(n)) |>
  ungroup()|>
  arrange(desc(Q2))|>
  mutate(share = scales::percent(share, accuracty = 1))
data_fr |> 
  filter(Student == "Yes") |>
  count(Gender, Q3) |>
  group_by(Gender) |>
  mutate(share = n / sum(n)) |>
  ungroup()|>
  arrange(desc(Q3))|>
  mutate(share = scales::percent(share, accuracty = 1))
data_fr |> 
  filter(Student == "Yes") |>
  count(Gender, Q4) |>
  group_by(Gender) |>
  mutate(share = n / sum(n)) |>
  ungroup()|>
  arrange(desc(Q4))|>
  mutate(share = scales::percent(share, accuracty = 1))
data_fr |> 
  filter(Student == "Yes") |>
  count(Gender, Q5) |>
  group_by(Gender) |>
  mutate(share = n / sum(n)) |>
  ungroup()|>
  arrange(desc(Q5))|>
  mutate(share = scales::percent(share, accuracty = 1))
data_fr |> 
  filter(Student == "Yes") |>
  count(Gender, Q6) |>
  group_by(Gender) |>
  mutate(share = n / sum(n)) |>
  ungroup()|>
  arrange(desc(Q6))|>
  mutate(share = scales::percent(share, accuracty = 1))
data_fr |> 
  filter(Student == "Yes") |>
  count(Gender, Q7) |>
  group_by(Gender) |>
  mutate(share = n / sum(n)) |>
  ungroup()|>
  arrange(desc(Q7))|>
  mutate(share = scales::percent(share, accuracty = 1))

#### Reviewer comments ###
#Is it clear what steps you need to take to run the script?
# Pretty clear. Just needed to adjust the path in the beginning to load the data, but otherwise good.

#When you follow those steps, does the script run?
# The script runs smoothly and fast. It is readable and not redundant.

#Is the html file from the repository reproducible?
# Yes it is reproducible.

#How easy or difficult is it to read the script and understand what the author is doing and why?
# I would have liked a sentence or two on the motivation for this project to contextualize it better.
# But once I looked at the visualizations I was able to make sense of what the author was trying to do and why.
# Overall, the script accomplishes it's purpose in an efficient way.


