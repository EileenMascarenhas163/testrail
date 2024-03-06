
install.packages('mongolite')

library(mongolite)

data4 = mongo(collection = 'crimes', db = 'TyIt')

data4$count()

install.packages('lubridate')
library(lubridate)

domestic = data4$find('{"Domestic":true}',fields ='{"_id":0,"Domestic":1,"Date":1}')

summary(domestic)

domestic$Date = mdy_hms(domestic$Date)

domestic$Weekday = weekdays(domestic$Date)

WeekdayCounts = as.data.frame(table(domestic$Weekday))

library(ggplot2)

WeekdayCounts$Var1 = factor(WeekdayCounts$Var1, ordered = TRUE, levels=c("Sunday","Monday","Tuesday","Wednesday","Thursday","Friday","Saturday"))

ggplot(data=WeekdayCounts, aes(x=Var1, y=Freq, group=1)) +geom_line(color="pink",size=1.5)+geom_point()+ggtitle("Crimes")+
  labs(x="Weekdays",y="Number of Crimes")

domestic$Hour = hour(domestic$Date)

HourCounts = as.data.frame(table(domestic$Hour))

ggplot(data=HourCounts, aes(x=Var1, y=Freq, group=1)) +geom_line(color="pink",size=1.5)+geom_point()+ggtitle("Crimes")+
  labs(x="Hour",y="Number of Crimes")


DayHourCounts = as.data.frame(table(domestic$Weekday,domestic$Hour))

DayHourCounts

ggplot(data=DayHourCounts, aes(x=Var2, y=Freq)) +geom_line(aes(color=Var1,group=Var1),size=1)+geom_point()+ggtitle("Crimes")+
  labs(x="Hour",y="Number of Crimes")




data1 = read.csv('d.csv')

data1


#question - find state wise how many seats secured by bjp


data1 %>% filter(Party.Abbreviation == 'BJP') %>% filter(Winner.or.Not.== 'yes') %>% group_by(Name.of.State..UT)%>% count(Party.Abbreviation)

