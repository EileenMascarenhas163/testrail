print(getwd())

data <- read.csv("election.csv")

summary(data)

#install dplyr
library(dplyr)

#Q1-winner of each constituency
winner_details = data %>% group_by(PC.NAME) %>% filter(TOTAL == max(TOTAL)) %>% select(PC.NAME, CANDIDATES.NAME, TOTAL)
winner_details

write.csv(winner_details, 'winners.csv')

#Q2-second place
len = length(data)
second = data %>% group_by(PC.NAME) %>% arrange(desc(TOTAL)) %>% slice(2) %>% select(PC.NAME, CANDIDATES.NAME, TOTAL)

#Q3-margin

#converting to data frame
win_df = data.frame(winner_details)
sec_df = data.frame(second)

#merging the two data frames
combined = merge(win_df,sec_df, by='PC.NAME')
combined

combined$margin = combined$TOTAL.x - combined$TOTAL.y
combined

write.csv(combined, 'margin.csv')

#Q4-maharashtra's constituency

maha_sec = data %>% group_by(PC.NAME) %>% filter(State.Name=='Maharashtra') %>% arrange(desc(TOTAL)) %>% slice(2) %>% select(PC.NAME, CANDIDATES.NAME, TOTAL)
maha_win = data %>% group_by(PC.NAME) %>% filter(State.Name=='Maharashtra') %>% arrange(desc(TOTAL)) %>% slice(1) %>% select(PC.NAME, CANDIDATES.NAME, TOTAL)

win_maha = data.frame(maha_win)
sec_maha = data.frame(maha_sec)

combined_maha = merge(win_maha,sec_maha,by='PC.NAME')

margin$combined_maha = combined_maha$TOTAL.x - combined_maha$TOTAL.y
write.csv(combined_maha, 'maha_margin.csv')

#Q5-how many seats did each political party won
win = data %>% group_by(PC.NAME) %>% arrange(desc(TOTAL)) %>% slice(1) %>% select(PC.NAME, PARTY.NAME, CANDIDATES.NAME, TOTAL)

seats = win %>% group_by(PARTY.NAME) %>% filter(PARTY.NAME=='BJP')%>%count(PARTY.NAME) 
write.csv(seats, 'seats.csv')

seat2 = win %>% group_by(PARTY.NAME) %>% count(PARTY.NAME) %>% arrange(desc(n))
