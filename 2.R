install.packages('mongolite')

library(mongolite)

my_data = mongo(collection = 'crimes', db = 'TyIt')

my_data$count()

my_data$iterate()$one()

length(my_data$distinct('Primary Type'))

#top 10 locations where maximum crimes are taking place

data2 <- read.csv("crimes.csv")
summary(data2)

install.packages('dplyr')
library(dplyr)

top10 = data2 %>% group_by(Location.Description) %>% count() %>% arrange(desc(n)) %>% head(10)
top10

library(ggplot2)

ggplot(top10, aes(x=n, y=Location.Description))

ggplot(top10, aes(x=Location.Description, y=n, fill=n)) + geom_bar(stat = 'identity')+xlab("Total Crimes") + ylab("Locations") + # Set axis labels
  ggtitle("Top10 Crime Locations") +     # Set title
  theme_classic() + coord_flip()

#through mongo
mongoTop10 = my_data$aggregate('[{"$group":{"_id":"$Location Description", "Count": {"$sum":1}}}]') %>% arrange(desc(Count)) %>% head(10)

ggplot(mongoTop10, aes(x=reorder(`_id`,Count), y=Count, fill=Count)) + geom_bar(stat = 'identity')+xlab("Total Crimes") + ylab("Locations") + # Set axis labels
  ggtitle("Top10 Crime Locations") +     # Set title
  theme_classic() + coord_flip()
