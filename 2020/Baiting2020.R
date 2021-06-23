


######## USE ############################################################################################
#############################################################################
#####################################################################################################


# SORT daily
#####################################################################################################
#####################################################################################################
library(dplyr)
library(gtools)
library(lattice)
library(ggplot2)
library(RColorBrewer)
library(psych)

setwd("~/Carp/2020")
pit1 <-read.csv("Parley_Halsteads_PIT_2019.csv") 
pit2 <-read.csv("Extra_PIT_2020.csv") 
apit <-read.csv("All_PIT.csv") 
head(pit1)
head(pit2)
head(apit)

recaps <-read.csv("Parley_Recaps_2020.csv") 




s1 <-read.csv("SITE_1_2020.csv")
s2 <-read.csv("SITE_2_2020.csv")
s3 <-read.csv("SITE_3_2020.csv")
s4 <-read.csv("SITE_4_2020.csv")
s5 <-read.csv("SITE_5_2020.csv")
s6 <-read.csv("SITE_6_2020.csv")
s7 <-read.csv("SITE_7_2020.csv")
s8 <-read.csv("SITE_8_2020.csv")

head(s1$Date)

############## recaps #####################

alls <- rbind(s1,s2,s3,s4,s5,s6,s7,s8, Fill=NA)
head(alls)

detect <- merge(alls, recaps, by="PIT")
unique(detect$PIT)
head(detect)

subset(detect, Date.y = "7/23/2020")-> detects
head(detects)

detect %>%
group_by(PIT, Date.x, Site) %>%
count(n_distinct(Site)) -> sort1
sort1%>% print(n=700)

write.csv(sort1, file="sites_after_cap")



###### #############  total detections per day ######


alls <- rbind(s1,s2,s3,s4,s5,s6,s7,s8, Fill=NA)
head(alls)

detect <- merge(alls, apit, by="PIT")
unique(detect$PIT)



head(detect)
detect%>%
group_by(Date) %>%
count(n_distinct (PIT))  -> detectpp
detectpp %>% print(n=700)

as.data.frame(detectpp)
detectpp$Date = as.Date(detectpp$Date, format = "%m/%d/%y")

subset(detectpp, Date < "2023-01-01")-> detectsa
arrange(detectsa, Date) -> detectsad
head(detectsad)
detectsad %>% print(n=700)

as.data.frame(detectsad)
names(detectsad) <- c("Date" ,"UniquePIT", "DailyVisits")


ggplot(detectsad, aes(x=Date, y=DailyVisits)) +geom_point()+ geom_line()+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1))




############### how many per year
alls <- rbind(s1,s2,s3,s4,s5,s6,s7,s8, Fill=NA)
head(alls)

nineteen <- merge(pit1, alls, by="PIT")
unique(nineteen$PIT) -> teen
length(teen)

 

twenty <- merge(pit2, alls, by="PIT")
unique(twenty$PIT) -> twen
length(twen)


########### total unique


detect <- merge(alls, apit, by="PIT")
unique(detect$PIT)

############################ unique percent


detect %>%
group_by(Site,PIT) %>%
count(n_distinct(PIT)) -> lake
lake%>% print(n=700)

as.data.frame(lake)
names(lake)<-c("Site", "PIT", "Count")
head(lake)

aggregate(Site ~ PIT, lake, FUN = unique) -> lake2

lake2 <- apply(lake2,2,as.character)

lake3 <- lake2[,2]
write.csv(lake3, file="unique_per_site")

###### unique percent after new site added ######








######## tagging location #######


detect %>%
group_by(Site) %>%
count(n_distinct(PIT/Site)) -> lake
lake%>% print(n=700)



###############    How many carp detected at each site, 


s1p<- merge(apit, s1, by="PIT")
head(s1p)
unique(s1p$PIT) ->a
length(a)


s2p<- merge(apit, s2, by="PIT")
head(s2p)
unique(s2p$PIT) ->b
length(b)


s3p<- merge(apit, s3, by="PIT")
head(s3p)
unique(s3p$PIT)->c
length(c)

s4p<- merge(apit, s4, by="PIT")
head(s4p)
unique(s4p$PIT) ->d
length(d)

s5p<- merge(apit, s5, by="PIT")
head(s5p)
unique(s5p$PIT) ->e
length(e)


s6p<- merge(apit, s6, by="PIT")
head(s6p)
unique(s6p$PIT) -> f
length(f)


s7p<- merge(apit, s7, by="PIT")
head(s7p)
unique(s7p$PIT) ->g
length(g)


s8p<- merge(apit, s8, by="PIT")
head(s8p)
unique(s8p$PIT) ->h
length(h)

######### how many switched sites,


alls <- rbind(s1,s2,s3,s4,s5,s6,s7,s8, Fill=NA)
head(alls)


detect <- merge(alls, apit, by="PIT")
tail(detect)



detect %>%
group_by(PIT) %>%
count(n_distinct(Site)) -> sort1
sort1%>% print(n=700)


sort1 %>%
group_by(`n_distinct(Site)`) %>%
count(n_distinct (PIT))  -> sort2
sort2%>% print(n=700)


############# days detected at site

detect %>%
group_by(PIT) %>%
count(n_distinct(Date)) -> datesall
datesall%>% print(n=700)


as.data.frame(datesall) -> datesall

names(datesall) <- c("PIT" ,"Days","n")

head(datesall)


summary(datesall)
describe(datesall)

datesall[with(datesall, order(-Days)), ] -> test
test%>% print(n=700)


ggplot(data=datesall, aes(x=reorder(PIT, -Days), y=Days)) +geom_bar(stat="identity") +geom_text(aes(label=Days), vjust=0) 







########### total unique


detect %>%
summarize(n_distinct (PIT)) 

unique(detect$PIT)



 ########### detections over time overall and at each site, 



head(detect)
detect%>%
group_by(Date,Site) %>%
count(n_distinct (PIT))  -> detectsa
detectsa %>% print(n=700)

as.data.frame(detectsa)
detectsa$Date = as.Date(detectsa$Date, format = "%m/%d/%y")

subset(detectsa, Date < "2023-01-01")-> detectsa
arrange(detectsa, Date) -> detectsad
head(detectsad)

as.data.frame(detectsad)
names(detectsad) <- c("Date" ,"Site","Unique")

as.factor(detectsad$Site)->detectsad$Site
myColors <- brewer.pal(8,"Set1")
names(myColors) <- levels(detectsad$Site)
colScale <- scale_colour_manual(name = "Site",values = myColors)



ggplot(detectsad, aes(x=Date, y=Unique, color=Site)) +geom_point()+ geom_line()+ theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) ->p
 p + colScale









######################## OLD WORK BELOW ########################################







############### hwy 8 vs EGS ############## just my tags ########
test<-read.csv("HWY8_ALL.csv")
hwy8<- merge(pit1, test,  by="PIT")
pits<-read.csv("egs_down_all.csv")
egs<- merge(pit1, pits,  by="PIT")
c_hwy8<- subset(hwy8, Species == "Ccarp") 
c_egs<- subset(egs, Species == "Ccarp") 

c_hwy8 %>%
group_by(Date.y) %>%
summarize(n_distinct (PIT)) -> c_hwy8d
 c_hwy8d%>% print(n=700)

c_egs %>%
group_by(Date.y) %>%
summarize(n_distinct (PIT)) -> c_egsd
 c_egsd%>% print(n=700)
as.data.frame(c_egsd) -> c_egsd
as.data.frame(c_hwy8d) -> c_hwy8d
 c_egsd[-c(1, 2), ] ->c_egsd

c_egsd$Location <- 1
c_hwy8d$Location <- 2

rbind(c_egsd, c_hwy8d) -> data

names(data) <- c("Date", "Count", "Location")


data
?as.Date 

library(ggplot2)

data$Date = as.Date(data$Date, format = "%m/%d/%y")
arrange(data, Date, Location) -> data
ggplot(data, aes(x=Date, y=Count, color=Location)) +geom_point() + 

theme(axis.text.x = element_text(angle = 45, vjust = 1, hjust=1)) +geom_jitter()






############ egs2 tests   ###############################################
test<-read.csv("egs2_6_5_19.csv")
sorts<- merge(allp, test,  by="PIT")


sort %>%
group_by(Date) %>%
summarize(n_distinct (PIT)) -> sort2
sort2%>% print(n=700)


arrange(sort2, Date, Time, Ant) -> sort3
sort3%>% print(n=7000)


################################################################# net tests


hwy8<-read.csv("hwy8_4_29_19.csv")
sort<- merge(pit1, hwy8,  by="PIT")
head(sort)

pit<-read.csv("GATE_MASTER.csv")
sort<- merge(allp, pit,  by="PIT")
tail(sort)


pits<-read.csv("egs_down_all.csv")
sorts<- merge(pit1, pits,  by="PIT")
tail(sorts)
unique(sorts$PIT)

########## quick uniqe per day
as.Date(pit$Date, "%m/%d/%Y", tx - "CST") -> pit$Date
subset(pit, Date == "0019-04-19") -> day1
unique(day1$PIT)


############################ sort by date and hour


sorts %>%
group_by(Species, Date.y, Hour) %>%
summarize(n_distinct (PIT)) -> sort2
sort2%>% print(n=700)


arrange(sort2, Date.y, Hour) -> sort3
sort3%>% print(n=700)






#########  sort by date
sorts %>%
group_by(Species, Date.y) %>%
summarize(n_distinct (PIT)) -> sort2
sort2%>% print(n=700)

arrange(sort2, Species, Date.y) -> sort3
sort3%>% print(n=700)

write.csv(sort3, file="uiqueperday")




######### by species
sorts %>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> sort2
sort2%>% print(n=70)

write.csv(sort2, file="total_unique")


################### captured versus read in net #############
cap <- read.csv("Captured_whooshh.csv") 
pit<-read.csv("GATE_MASTER.csv")
sort<- merge(pit1, cap,  by="PIT")
head(sort)

sort %>%
group_by(Species.y) %>%
summarize(n_distinct (PIT)) -> sort2
sort2%>% print(n=70)





sort[with(sort, order(Species.x,Date.y)),]


write.csv(sort2, file="weekend&monday")

unique(sort2$PIT)

as.integer(sort2$Hour) ->sort2$Hour
as.Date(sort2$Date.x, "%m/%d/%Y", tx - "CST") -> sort2$Date.x
subset(sort2, Date.x == "0019-04-15") -> day1
head(day1)
day1%>% print(n=1000)

day1 %>%
group_by(Species,  PIT) %>%
summarize(n_distinct (PIT)) -> day1b
day1b %>% print(n=1000)

as.integer(sort2$Hour) ->sort2$Hour
as.Date(sort2$Date.x, "%m/%d/%Y", tx - "CST") -> sort2$Date.x
subset(sort2, Date.x == "0019-04-13" & Hour >=18 | Date.x == "0019-04-14" & Hour <= 9  ) -> day1
head(day1)
day1%>% print(n=1000)

day1 %>%
group_by(Species,  PIT) %>%
summarize(n_distinct (PIT)) -> day1b
day1b %>% print(n=1000)



subset(sort2, Date.x == "0019-04-09" & Hour >=20 | Date.x == "0019-04-10" & Hour <= 9  ) -> day2
day2 %>% print(n=1000)

day2 %>%
group_by(Species,  PIT) %>%
summarize(n_distinct (PIT)) -> day2b
day2b %>% print(n=1000)


day1b[!(day1b %in% day2b)] -> compare
compare%>% print(n=1000)




				########################		captured vs detected   ########################
sort %>%
group_by(Species, Date.x, PIT) %>%
summarize(n_distinct (PIT)) -> sort2
sort2%>% print(n=1000)
	
subset(sort2, Date.x == "0019-04-08" & Hour >=18 | Date.x == "0019-04-09" & Hour <= 9  ) -> day1
head(day1)
day1%>% print(n=1000)	
	
day1 %>%
group_by(Species,  PIT) %>%
summarize(n_distinct (PIT)) -> day1b
day1b %>% print(n=1000)
	
caught <-read.csv("Captured_whooshh.csv") 	
	caught
	
ifelse(caught$PIT %in% day1b$PIT, 1, 0)


ifelse(caught$PIT %in% day2b$PIT, 1, 0)
	
	
ifelse(caught$PIT %in% sort2$PIT, 1, 0)	
	
ifelse(caught$PIT %in% allp$PIT, 1, 0)	
	
	
	
	
	
	
	
	
	
	

					################## postive control ##############

all<-read.csv("lily_pads_working_all.csv")
pit <-read.csv("corn_sort.csv") 
lily<- merge(all, pit,  by="PIT")
head(lily)
unique(lily$DATE)

all2<-read.csv("coffee_guy_working.csv")
coffee<- merge(all2, pit,  by="PIT")
head(coffee)

all3<-read.csv("kens_working_all.csv")
kens<- merge(all3, pit,  by="PIT")
head(kens)

lily$site<-"L"
coffee$site<-"C"
kens$site<-"K"

site <- rbind(lily,coffee,kens) 
head(site)




site %>%
group_by(Species, DATE, site) %>%
summarize(n_distinct (PIT)) -> site1
site1%>% print(n=200)


names(site1) <- c("species" ,"date", "site", "count")
as.Date(site1$date, "%m/%d/%Y") -> site1$date

subset(site1, date > "0018-10-02") -> site1
site1 <- droplevels(site1)
site1
xyplot(count ~ date|species, site1, group=site, xlab="Date",ylab="Daily Unique Count", main="Site", factor=1, jitter.x=TRUE,key = list(text = list(as.character(unique(site1$site))), points = list(pch = 20:22, col = 1:2)), pch = 20:22, col = 1:2)




				################## JOHNS ##############

pit <-read.csv("corn_sort.csv")
all4<-read.csv("johns_working_all.csv")
johns<- merge(all4, pit,  by="PIT")
head(johns)

as.Date(johns$DATE, "%m/%d/%Y", tx - "CST") -> johns$DATE

johns%>%
group_by(Species, DATE) %>%
summarize(n_distinct (PIT)) -> johns2
johns2 %>% print(n=101)


names(johns2) <- c("species" ,"date", "count")
johns2 <- droplevels(johns2)

xyplot(count ~ date, johns2,group=species, xlab="Date",ylab="Daily Unique Count", main="Species", factor=1, jitter.x=TRUE,key = list(text = list(as.character(unique(johns2$species))), points = list(pch = 20:23, col = 1:3)), pch = 20:23, col = 1:3, xlim=as.Date(c("0018-08-21","0018-10-02")),ylim=c(-4,70))


			####### BOTH  ######

johns2$site<-"J"
kens1$site<-"K"
kens1 <-as.data.frame(kens1)
johns2<-as.data.frame(johns2)

both <- rbind(kens1,johns2) 
head(both)



xyplot(count ~ date|site, both, group=species, xlab="Date",ylab="Daily Unique Count", main="Species", factor=1.5, jitter.x=TRUE,jitter.y=TRUE, key = list(text = list(as.character(unique(both$species))), points = list(cex=1,pch = 19, col = 1:6)), cex=1,pch = 19, col = 1:6,ylim=c(-4,70),xlim=as.Date(c("0018-08-21","0018-10-03")),scales=list(x=list(rot=45, cex=0.75)))





		#### #### #### ####    daily   #### #### #### #### #### #### #### #### #### 






names(test) <- c("species" ,"month", "pit","date","site","count")
head(test)

as.Date(test$date, "%m/%d/%Y") -> test$date
test %>%
group_by(species, date,site) %>%
summarize(n_distinct (pit)) -> test2
test2%>% print(n=200)
names(test2) <- c("species" ,"date","site", "count")
head(test2)
test2$species






subset(test2, species =="Ccarp") -> cc
subset(test2, species =="Y_Bullhead") -> yb
subset(test2, species =="WS") -> ws
subset(test2, species =="BLU") -> bg
subset(test2, species =="Sheepshead") -> sh
subset(test2, species =="LMB") -> LM
subset(test2, species =="B_Bullhead") -> bb





####log######

xyplot((log10(count)+1) ~ date,test2, group=site, xlab="Date",ylab="LOG Daily Unique Count", main="CARP",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)



### normal


xyplot(count ~ date,test2, group=site, xlab="Date",ylab="Daily Unique Count", main="carp",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)


##### all species

xyplot(count ~ date|site,test2, group=species, xlab="Date",ylab="Daily Unique Count", main="allspecies",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)

xyplot((log10(count)+1) ~ date|site,test2, group=species, xlab="Date",ylab="LOG Daily Unique Count", main="all",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)


############


xyplot(count ~ date|species,test2, group=site, xlab="Date",ylab="Daily Unique Count", main="allspecies",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)

xyplot((log10(count)+1) ~ date|species,test2, group=site, xlab="Date",ylab="LOG Daily Unique Count", main="all",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)





####### measuring fishes during videos #################

## 9/26/2018 #####

library(dplyr)
library(lattice)
pit <-read.csv("corn_sort.csv")
ken<-read.csv("kens_working_all.csv")
kens<- merge(ken, pit,  by="PIT")
as.Date(kens$DATE, "%m/%d/%Y", tx - "CST") -> kens$DATE
subset(kens, DATE == "0018-09-26") -> day1 
head(day1)
as.character(day1$TIME) -> day1$TIME

subset(day1, TIME >= "11:46" & TIME <= "17:40") -> day1_t
head(day1_t2)


day1_t%>%
group_by(Species,TIME,PIT) %>%
summarize(n_distinct (PIT)) -> day1_t2
day1_t2 %>% print(n=301)
day1_t2$Length
names(day1_t2) <- c("species" ,"time", "pit","count")

day1_t2%>%
group_by(pit) %>%
summarize(n_distinct (pit)) -> day1_t3
day1_t3
as.factor(day1_t2$time) -> day1_t2$time
day1_t3 %>% print(n=301)
xyplot(count ~ time|pit,day1_t2, ,ylab="pit", main="common carp")


## 9/28/2018 #####

library(dplyr)
library(lattice)
pit <-read.csv("corn_sort.csv")
ken<-read.csv("kens_working_all.csv")
kens<- merge(ken, pit,  by="PIT")
as.Date(kens$DATE, "%m/%d/%Y", tx - "CST") -> kens$DATE
subset(kens, DATE == "0018-09-28") -> day2 
head(day2)
as.character(day2$TIME) -> day2$TIME

subset(day2, TIME >= "10:59" & TIME <= "16:60") -> day2_t
head(day2_t2)


day2_t%>%
group_by(Species,TIME,PIT) %>%
summarize(n_distinct (PIT)) -> day2_t2
day2_t2 %>% print(n=301)

head(day2_t2)

names(day2_t2) <- c("species" ,"time", "pit","count")
day2_t2%>%
group_by(species,pit) %>%
summarize(n_distinct (pit)) -> day2_t3
day2_t3 %>% print(n=301)

as.factor(day2_t2$time) -> day2_t2$time

xyplot(count ~ time|pit,day2_t2, ,ylab="pit", main="common carp")

## 10/01/2018 #####

library(dplyr)
library(lattice)
pit <-read.csv("corn_sort.csv")
ken<-read.csv("kens_working_all.csv")
kens<- merge(ken, pit,  by="PIT")
as.Date(kens$DATE, "%m/%d/%Y", tx - "CST") -> kens$DATE
subset(kens, DATE == "0018-10-01") -> day3 
head(day3)
as.character(day3$TIME) -> day3$TIME

subset(day3, TIME >= "17:10" & TIME <= "22:18") -> day3_t



day3_t%>%
group_by(Species,TIME,PIT) %>%
summarize(n_distinct (PIT)) -> day3_t2
day3_t2 %>% print(n=301)

head(day3_t2)

names(day3_t2) <- c("species" ,"time", "pit","count")
day3_t2%>%
group_by(species,pit) %>%
summarize(n_distinct (pit)) -> day3_t3
day3_t3 %>% print(n=301)

as.factor(day3_t2$time) -> day3_t2$time

xyplot(count ~ time|pit,day3_t2, ,ylab="pit", main="common carp")



########## fish found at kens and johns########## ########## ########## 

pit <-read.csv("corn_sort.csv")
ken<-read.csv("kens_working_all.csv")
kens<- merge(ken, pit,  by="PIT")
as.Date(kens$DATE, "%m/%d/%Y", tx - "CST") -> kens$DATE
subset(kens, DATE <= "0018-09-10") -> precorn

all4<-read.csv("johns_working_all.csv")
johns<- merge(all4, pit,  by="PIT")
as.Date(johns$DATE, "%m/%d/%Y", tx - "CST") -> johns$DATE
subset(johns, DATE <= "0018-09-10") -> precorn_j
head(precorn_j)
kvj<- merge(precorn_j, precorn,  by="PIT")
kvj

pit <-read.csv("corn_sort.csv")
ken<-read.csv("kens_working_all.csv")
kens<- merge(ken, pit,  by="PIT")
as.Date(kens$DATE, "%m/%d/%Y", tx - "CST") -> kens$DATE
subset(kens, DATE >= "0018-09-10") -> corn

all4<-read.csv("johns_working_all.csv")
johns<- merge(all4, pit,  by="PIT")
as.Date(johns$DATE, "%m/%d/%Y", tx - "CST") -> johns$DATE
subset(johns, DATE >= "0018-09-10") -> corn_j
head(corn_j)
kvj2<- merge(corn_j, corn,  by="PIT", all=FALSE)
kvj2%>%
group_by(Species.x) %>%
summarize(n_distinct (PIT)) -> kvj_corn
kvj_corn %>% print(n=101)

########### kens #########################
#################################################################################################################################################################################################################################


####### couting total fish during each stage #######
library(dplyr)
library(lattice)
pit <-read.csv("corn_sort.csv")
tail(pit)
summary(pit$Species)


ken<-read.csv("kens_working_all.csv")
kens<- merge(ken, pit,  by="PIT")
head(kens)
as.Date(kens$DATE, "%m/%d/%Y", tx - "CST") -> kens$DATE

subset(kens, DATE <= "0018-09-10") -> precorn
precorn%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> precorn2
precorn2 %>% print(n=101)
unique(precorn$DATE)

subset(kens, DATE >= "0018-09-10" & DATE <= "0018-10-02") -> corn
head(corn)
subset(corn, Species=="Ccarp") -> corn
corn%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> corn2
corn2 %>% print(n=101)
unique(corn$DATE)



################ number of visists per carp over corn period

corn %>%
group_by(PIT) %>%
summarize(n_distinct (DAY)) -> test
test %>% print(n=200)

names(test) <- c("pit" ,"count")
summary(test$count)


hist(test$count, cex=100, plot=TRUE, ylim=range(0,110), ylab="Count", breaks=23, labels=TRUE)

######## cummlative

library(dplyr)
library(lattice)
library(ggplot2)
library(data.table)

corn %>%
group_by(DATE,PIT) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=200)
names(test) <- c("date" , "pit","count")

setDT(test)
test[, v_eff := count - shift(count, fill=0), by=.(pit)]
test[, cumulative := cumsum(v_eff)]

as.data.frame(test)
head(test)
test %>%
group_by(date) %>%
summarize(max(cumulative)) -> test
test %>% print(n=200)
names(test) <- c("date" , "cumulative")

test %>%
group_by(date) %>%
summarize(max(cumulative)) -> test
test %>% print(n=200)

names(test) <- c("date" , "cumulative")

ggplot(test, aes(date,cumulative)) + geom_histogram(stat = 'identity',binwidth=.25, colour="black", fill="black") + xlab("Date") + ylab("cumulative carp") + ggtitle("Cumulative carp during corn baiting")



###### number of new unqiues per day  ############

testx = diff(test$cumulative)
testx = append(9,testx)
print(testx)

test$test<-testx
test


test %>%
group_by(date) %>%
summarize(max(test)) -> test
test %>% print(n=200)
names(test) <- c("date" , "cumulative")

ggplot(test, aes(date,cumulative)) + geom_histogram(stat = 'identity',binwidth=.25, colour="black", fill="black") + xlab("Date") + ylab("new unique carp") + ggtitle("number of new unqiue carp per day during corn baiting")



#### number of unqiue hours based on < 2 days and == 12 days == 24 days

subset(corn, Species =="Ccarp")-> cc
head(cc)
unique(cc$DATE)

cc%>%
group_by(PIT) %>%
summarize(c_date=n_distinct (DATE)) -> cc2
cc2 %>% print(n=11)
cc$date
write.csv(cc2,file="total_days_per")

cc%>%
group_by(PIT,DATE,HOUR) %>%
summarize(c_date=n_distinct (DATE)) -> cc2
cc2 %>% print(n=11)



names(cc2) <- c("pit", "date","hour","c_date")

cc2 %>% group_by(pit) %>% mutate(count=sum(n_distinct (hour))) ->cc3
cc3 %>% group_by(pit) %>%
summarize(count=max(count)) -> cc4

cc4 %>% print(n=101)
write.csv(cc4,file="uniquehours.csv")


subset(cc2, c_date <= "2"  ) -> two
subset(cc2, c_date <= "12"  ) -> twelve
subset(cc2, c_date >= "22"  ) -> twentyfour






subset(kens, DATE >= "0018-10-02") -> trout
head(trout)
unique(trout$DATE)
trout%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> trout
trout %>% print(n=101)

### WHOOSHHHHH ####

ken<-read.csv("kens_working_all.csv")
pit2 <-read.csv("Whooshh_tags_all.csv") 
kens_w<- merge(ken, pit2,  by="PIT")
head(kens_w)
as.Date(kens_w$DATE, "%m/%d/%Y", tx - "CST") -> kens_w$DATE

subset(kens_w, DATE <= "0018-09-10") -> precorn_w
precorn_w%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> precorn_w2
precorn_w2 %>% print(n=101)

subset(kens_w, DATE >= "0018-09-10" & DATE <= "0018-10-02") -> corn_w
head(corn_w)

corn_w%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> corn_w2
corn_w2 %>% print(n=101)

subset(kens_w, DATE >= "0018-10-02") -> trout_w
head(trout_w)

trout_w%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> trout_w
trout_w %>% print(n=101)

###### carp sol ################

pit3 <-read.csv("RCWD PIT tags.csv") 
kens_r<- merge(ken, pit3,  by="PIT")
head(pit3)
head(kens_r)
summary(pit3$Species)

as.Date(kens_r$DATE, "%m/%d/%Y", tx - "CST") -> kens_r$DATE

subset(kens_r, DATE <= "0018-09-10") -> precorn_r
precorn_r%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> precorn_r2
precorn_r2 %>% print(n=101)

subset(kens_r, DATE >= "0018-09-10" & DATE <= "0018-10-02") -> corn_r
head(corn_r)

corn_r%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> corn_r2
corn_r2 %>% print(n=101)

subset(kens_r, DATE >= "0018-10-02") -> trout_r
head(trout_r)

trout_r%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> trout_r
trout_r %>% print(n=101)


################## lily pad ####################
#############################################################################################################################

library(dplyr)
library(lattice)
pit <-read.csv("corn_sort.csv")
tail(pit)
summary(pit$Species)


lily<-read.csv("lily_pads_working_all.csv")
lily_p<- merge(lily, pit,  by="PIT")
head(lily_p)
as.Date(lily_p$DATE, "%m/%d/%Y", tx - "CST") -> lily_p$DATE


lily_p%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> lily_p2
lily_p2 %>% print(n=101)
unique(lily_p$DATE)

### WHOOSHHHHH ####

lily<-read.csv("lily_pads_working_all.csv")
pit2 <-read.csv("Whooshh_tags_all.csv") 
lily_w<- merge(lily, pit2,  by="PIT")
head(lily_w)
as.Date(lily_w$DATE, "%m/%d/%Y", tx - "CST") -> lily_w$DATE

lily_w%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> lily_w2
lily_w2 %>% print(n=101)


###### carp sol ################

lily<-read.csv("lily_pads_working_all.csv")
pit3 <-read.csv("RCWD PIT tags.csv") 
lily_r<- merge(lily, pit3,  by="PIT")
head(pit3)
head(lily_r)
summary(pit3$Species)

as.Date(lily_r$DATE, "%m/%d/%Y", tx - "CST") -> lily_r$DATE

lily_r%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> lily_r2
lily_r2 %>% print(n=101)


################## coffee guy ####################
#############################################################################################################################

library(dplyr)
library(lattice)
pit <-read.csv("corn_sort.csv")
tail(pit)
summary(pit$Species)


coffee<-read.csv("coffee_guy_working.csv")
coffee_p<- merge(coffee, pit,  by="PIT")
head(coffee_p)
as.Date(coffee_p$DATE, "%m/%d/%Y", tx - "CST") -> coffee_p$DATE
coffee_p$DATE

coffee_p%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> coffee_p2
coffee_p2 %>% print(n=101)
unique(coffee_p$DATE)

### WHOOSHHHHH ####

coffee<-read.csv("coffee_guy_working.csv")
pit2 <-read.csv("Whooshh_tags_all.csv") 
coffee_w<- merge(coffee, pit2,  by="PIT")
head(coffee_w)
as.Date(coffee_w$DATE, "%m/%d/%Y", tx - "CST") -> coffee_w$DATE

coffee_w%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> coffee_w2
coffee_w2 %>% print(n=101)


###### carp sol ################

coffee<-read.csv("coffee_guy_working.csv")
pit3 <-read.csv("RCWD PIT tags.csv") 
coffee_r<- merge(coffee, pit3,  by="PIT")
head(pit3)
head(coffee_r)
summary(pit3$Species)

as.Date(coffee_r$DATE, "%m/%d/%Y", tx - "CST") -> coffee_r$DATE

coffee_r%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> coffee_r2
coffee_r2 %>% print(n=101)


################################ JOHNS negative #######################
############################################################################################################################################################################################################################################################################################################

pit <-read.csv("corn_sort.csv")
tail(pit)
summary(pit$Species)

all4<-read.csv("johns_working_all.csv")
johns<- merge(all4, pit,  by="PIT")
head(johns)

as.Date(johns$DATE, "%m/%d/%Y", tx - "CST") -> johns$DATE
unique(johns$DATE)
subset(johns, DATE <= "0018-09-10") -> precorn_j
precorn_j%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> precorn_j2
precorn_j2 %>% print(n=101)


subset(johns, DATE >= "0018-09-10") -> corn_j
head(corn_j)

corn_j%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> corn_j2
corn_j2 %>% print(n=101)


### WHOOSHHHHH ####

all4<-read.csv("johns_working_all.csv")
pit2 <-read.csv("Whooshh_tags_all.csv") 
johns_w<- merge(all4, pit2,  by="PIT")
head(johns_w)
as.Date(johns_w$DATE, "%m/%d/%Y", tx - "CST") -> johns_w$DATE

subset(johns_w, DATE <= "0018-09-10") -> precorn_jw
precorn_jw%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> precorn_jw2
precorn_jw2 %>% print(n=101)


subset(johns_w, DATE >= "0018-09-10") -> corn_jw
head(corn_jw)

corn_jw%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> corn_jw2
corn_jw2 %>% print(n=101)

###### carp sol ################

all4<-read.csv("johns_working_all.csv")
pit3 <-read.csv("RCWD PIT tags.csv") 
johns_r<- merge(all4, pit3,  by="PIT")
all4$DATE
head(johns_r)
summary(all4)

as.Date(johns_r$DATE, "%m/%d/%Y", tx - "CST") -> johns_r$DATE

subset(johns_r, DATE <= "0018-09-10") -> precorn_jr
summary(precorn_jr)
precorn_jr%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> precorn_jr2
precorn_jr2 %>% print(n=101)


subset(johns_r, DATE >= "0018-09-10") -> corn_jr
head(corn_jr)

corn_jr%>%
group_by(Species) %>%
summarize(n_distinct (PIT)) -> corn_jr2
corn_jr2 %>% print(n=101)


######## have fishes visited multiple site #####################
library(dplyr)
library(lattice)


all<-read.csv("lily_pads_working_all.csv")
pit <-read.csv("corn_sort.csv") 
lily<- merge(all, pit,  by="PIT")
head(lily)


all2<-read.csv("coffee_guy_working.csv")
coffee<- merge(all2, pit,  by="PIT")
head(coffee)


all3<-read.csv("kens_working_all.csv")
kens<- merge(all3, pit,  by="PIT")
head(kens)

all4<-read.csv("johns_working_all.csv")
johns<- merge(all4, pit,  by="PIT")
head(johns)

lily$site<-"L"
coffee$site<-"C"
kens$site<-"K"
johns$site<-"J"
as.character(coffee$PIT)->coffee$PIT
site <- rbind(lily,coffee,kens,johns) 
head(site)


site %>%
group_by(Species,MONTH, PIT,DATE, site, Section, Length) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)


####daily
names(test) <- c("species" ,"month", "pit","date","site", "section", "length","count")
head(test)
test%>% print(n=1400)

as.Date(test$date, "%m/%d/%Y") -> test$date
subset(test, species =="Ccarp") -> cc
head(cc)
xyplot(pit ~ date|species,test, group=site ,ylab="pit", main="all_species",auto.key = TRUE,scales=list(y=list( cex=0.35)))
xyplot(pit ~ date,cc, group=site ,ylab="pit", main="common carp",auto.key = TRUE,scales=list(y=list( cex=0.35)))



###### by length #######

cc %>%
group_by(pit,length) %>%
summarize(n_distinct (date)) -> test2
test2%>% print(n=1400)
names(test2) <- c("pit", "length", "count")
head(test2)


xyplot(length ~ count,test2, ,ylab="length", main="common carp",par.settings = list(superpose.symbol = list(pch = 16:25)), scales=list(x=list(rot=90, cex=0.75)))

############ by section ###############
subset(cc,site=="K")->cc
subset(cc, date  >= "0018-09-10" & date <= "0018-10-02") -> cc
head(cc)


cc %>%
group_by(pit,section) %>%
summarize(n_distinct (date)) -> test2
test2%>% print(n=1400)
names(test2) <- c("pit", "section", "count")
head(test2)

library(ggplot2)

mid<-median(test2$section)

ggplot(test2, aes(section,count,color=section)) + geom_histogram(stat = 'identity') + xlab("section") + ylab("carp count by section") + ggtitle("Carp during corn baiting by section") +scale_color_gradient2(midpoint=mid, low="green1", mid="black",high="red" )









########### by section and day ############
all<-read.csv("kens_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)


total %>%
group_by(Species,MONTH, PIT,DATE, site, Section, Length) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)


####daily
names(test) <- c("species" ,"month", "pit","date","site", "section", "length","count")
head(test)
test%>% print(n=1400)



(test, species =="Ccarp") -> cc


cc %>%
group_by(section, date, site) %>%
summarize(n_distinct (pit)) -> test2
test2%>% print(n=1400)
names(test2) <- c("section", "date", "site","count")
head(test2)


as.Date(test2$date, "%m/%d/%Y") -> test2$date


xyplot(count~section|date,test2, ,ylab="count", main="common carp",par.settings = list(superpose.symbol = list(pch = 16:25)), scales=list(x=list(rot=90, cex=0.75)),layout=c(5,5))




#####################################################################################################
#####################################################################################################
compare species in all sites
#####################################################################################################
#####################################################################################################
library(dplyr)
library(lattice)


all<-read.csv("lily_pads_working_all.csv")
pit <-read.csv("corn_sort.csv") 
lily<- merge(all, pit,  by="PIT")
head(lily)


all2<-read.csv("coffee_guy_working.csv")
coffee<- merge(all2, pit,  by="PIT")
head(coffee)


all3<-read.csv("kens_working_all.csv")
kens<- merge(all3, pit,  by="PIT")
head(kens)

all4<-read.csv("johns_working_all.csv")
johns<- merge(all4, pit,  by="PIT")
head(johns)

lily$site<-"L"
coffee$site<-"C"
kens$site<-"K"
johns$site<-"J"
as.character(coffee$PIT)->coffee$PIT
site <- rbind(lily,coffee,kens,johns) 
head(site)


site %>%
group_by(Species,MONTH, PIT,DATE, site) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)


names(test) <- c("species" ,"month", "pit","date","site","count")
head(test)
as.Date(test$date, "%m/%d/%Y") -> test$date
xyplot(count ~ date|pit,test, group=site, xlab="Date",ylab="Daily Unique Count", main="carp", cex=0.5,scales=list(x=list(rot=45, cex=0.35)),layout=c(5,5))



####daily
names(test) <- c("species" ,"month", "pit","date","site","count")
head(test)

as.Date(test$date, "%m/%d/%Y") -> test$date
test %>%
group_by(species, date,site) %>%
summarize(n_distinct (pit)) -> test2
test2%>% print(n=200)
names(test2) <- c("species" ,"date","site", "count")
head(test2)
test2$species






subset(test2, species =="Ccarp") -> cc
subset(test2, species =="Y_Bullhead") -> yb
subset(test2, species =="WS") -> ws
subset(test2, species =="BLU") -> bg
subset(test2, species =="Sheepshead") -> sh
subset(test2, species =="LMB") -> LM
subset(test2, species =="B_Bullhead") -> bb





####log######

xyplot((log10(count)+1) ~ date,test2, group=site, xlab="Date",ylab="LOG Daily Unique Count", main="CARP",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)



### normal


xyplot(count ~ date,test2, group=site, xlab="Date",ylab="Daily Unique Count", main="carp",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)


##### all species

xyplot(count ~ date|site,test2, group=species, xlab="Date",ylab="Daily Unique Count", main="allspecies",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)

xyplot((log10(count)+1) ~ date|site,test2, group=species, xlab="Date",ylab="LOG Daily Unique Count", main="all",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)


############


xyplot(count ~ date|species,test2, group=site, xlab="Date",ylab="Daily Unique Count", main="allspecies",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)

xyplot((log10(count)+1) ~ date|species,test2, group=site, xlab="Date",ylab="LOG Daily Unique Count", main="all",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)


################ hourly  ################

site %>%
group_by(Species,MONTH, HOUR, PIT,DATE, site) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)
head(test)

####daily
names(test) <- c("species" ,"month", "hour", "pit","date","site","count")
head(test)

as.Date(test$date, "%m/%d/%Y") -> test$date
test %>%
group_by(species, hour, date,site) %>%
summarize(n_distinct (pit)) -> test2
test2%>% print(n=200)
names(test2) <- c("species" , "hour","date","site", "count")
head(test2)
test2$species
test2$hour <- as.numeric(test2$hour, units = "hours")


xyplot(count ~ hour|species,test2, group=site, xlab="Date",ylab="Daily Unique Count", main="allspecies",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)




xyplot((log10(count)+1) ~ hour|date,test2, group=species, xlab="Date",ylab="LOG Daily Unique Count", main="all",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE,layout=c(5,5))



####### lily pad working all #######
library(dplyr)
library(lattice)
all<-read.csv("lily_pads_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)

total %>%
group_by(Species,MONTH, DATE, PIT) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)
names(test) <- c("species" ,"month","date", "pit","count")
test

as.Date(test$date, "%m/%d/%Y") -> test$date
test %>%
group_by(species, date) %>%
summarize(n_distinct (pit)) -> test2
test2%>% print(n=200)
names(test2) <- c("species" ,"date", "count")
head(test2)


xyplot((log10(count)+1) ~ date,test2, group=species, xlab="Date",ylab="Daily Unique Count", main="lily pad",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)

unique(test2$species)



####### coffee guy working all #######


library(dplyr)
library(lattice)
all<-read.csv("coffee_guy_working.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)

total %>%
group_by(Species,MONTH, DATE, PIT) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)
names(test) <- c("species" ,"month","date", "pit","count")
test

as.Date(test$date, "%m/%d/%Y") -> test$date
test %>%
group_by(species, date) %>%
summarize(n_distinct (pit)) -> test2
test2%>% print(n=200)
names(test2) <- c("species" ,"date", "count")
head(test2)

xyplot((log10(count)+1) ~ date,test2, group=species, xlab="Date",ylab="Daily Unique Count", main="coffee_guy",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.5, jitter.x=TRUE)




#################	a2 v a3		 and increase with double		#################
 




library(dplyr)
library(lattice)
all<-read.csv("kens_working_double.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)
total
total %>%
group_by(Species,MONTH, DAY, PIT, ANT) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=301)

names(test) <- c("species" ,"month","day", "pit", "ant","count")
head(test)


test %>%
group_by(pit, ant) %>%
summarize(n_distinct (day)) -> cc
cc%>% print(n=200)
test$day

subset(cc, ant=="A2")->x
subset(cc, ant=="A3")->y
y
setdiff(x$pit, y$pit) ->z

z




all3<-read.csv("kens_working_all.csv")
kens<- merge(all3, pit,  by="PIT")
head(kens)
kens %>%
group_by(Species,MONTH, DATE, PIT) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=31)

names(test) <- c("species" ,"month","date", "pit", "count")
head(test)


subset(test, species == "Ccarp") ->cc2
head(cc2)

cc2 %>%
group_by(date) %>%
summarize(d_count=n_distinct (pit)) -> test
test %>% print(n=45)
write.csv(test,file="test.csv")
					TREATMENT SITE       

####### number of days pit tags were at site  ###########

all<-read.csv("kens_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)

library(dplyr)
library(lattice)

head(total)


total %>%
group_by(Species,MONTH, DAY, PIT) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)


names(test) <- c("species" ,"month", "day", "pit","count")
head(test)

unique(test$pit)
subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg
head(cc)


#####  carp revisiting

cc %>%
group_by(pit) %>%
summarize(n_distinct (day)) -> test
test %>% print(n=200)
cc$day
names(test) <- c("pit" ,"count")
summary(test$count)




hist(test$count, cex=100, plot=TRUE, ylim=range(0,110), ylab="Count", breaks=24, labels=TRUE)
hist(test$count, cex=100, plot=TRUE, ylab="Count", w=2,labels=TRUE)


head(test)
test$count
write.csv(test, file="day_visit")
xyplot(count ~ pit, test, auto.key = TRUE, xlab="Day", ylab="Count",scales=list(x=list(rot=60, cex=0.55)))


####### by day  ###########

all<-read.csv("kens_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)

unique(day$PIT)
library(dplyr)


head(total)

total %>%
group_by(Species,DATE) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=1000)
head(test)





names(test) <- c("species" ,"date","count")
as.Date(test$date, "%m/%d/%Y") -> test$date

subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg

xyplot((log10(count)+1) ~ date,test, group=species, xlab="Date",ylab="Daily Unique Count", main="kens",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.5, jitter.x=TRUE)

xyplot(count ~ date, yb, auto.key = TRUE, xlab="Date", ylab="Count", ylim=c(0,3))
xyplot(count ~ date, ws, auto.key = TRUE, xlab="Date", ylab="Count",ylim=c(0,3))
xyplot(count ~ date, bg, auto.key = TRUE, xlab="Date", ylab="Count",ylim=c(0,3))



######## unqiue inididvuals for ecah species.


head(total)

total %>%
group_by(Species,DATE, PIT) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=1000)
head(test)

names(test) <- c("species" ,"date","pit","count")
subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg

cc %>%
group_by(species) %>%
summarize(n_distinct (pit)) -> cc2
cc2 %>% print(n=1000)

ws
yb %>%
group_by(species) %>%
summarize(n_distinct (pit)) -> yb2
yb2 %>% print(n=1000)

ws %>%
group_by(species) %>%
summarize(n_distinct (pit)) -> ws2
ws2 %>% print(n=1000)

bg %>%
group_by(species) %>%
summarize(n_distinct (pit)) -> bg2
bg2 %>% print(n=1000)




####### by hour look at species ###########



library(dplyr)

all<-read.csv("kens_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)


as.Date(total$DATE, "%m/%d/%Y") -> total$DATE

head(total)


total %>%
group_by(Species,PIT, MONTH, HOUR, DATE) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)

head(test)

names(test) <- c("species" ,"PIT","month", "hour","date","count")
head(test)

as.Date(test$date, "%m/%d/%Y") -> test$date
test %>%
group_by(species, hour, date) %>%
summarize(n_distinct (PIT)) -> test2
test2%>% print(n=200)
names(test2) <- c("species" , "hour","date", "count")
test2$hour <- as.numeric(test2$hour, units = "hours")

head(test2)



subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg
head(cc)
cc$day
summary(cc)
library(lattice)
############ daily vists by carp ########
xyplot(count~hour|date,test2, group=species,xlab="hour",cex=0.5,  ylab="TimesDetected",layout=c(2,4))



###CARP by hour
xyplot(hour ~ PIT, cc ,auto.key = TRUE, xlab="PIT", ylab="HOUR",jitter.data = TRUE, factor=5)

###yellow bullhead by hour
xyplot(count ~ hour, yb, group=day ,auto.key = TRUE, xlab="Day", ylab="Count")

###bluegill per hour
xyplot(count ~ hour, bg, group=day ,auto.key = TRUE, xlab="Day", ylab="Count")




##### by hour per indvidual #####
write.csv(cc, file="cctry")
cctry <-read.csv("cctry") 

head(cctry)
subset(cctry,  month>=9) -> rt
head(rt)
as.factor(rt$PIT)->rt$PIT
xyplot(hour~date, rt, xlab="hour",cex=0.5, auto.key=TRUE, xlim=c(-1,24), ylab="day")
rt$PIT

################## mean number of PIT per hour across all days since baiting began
head(cctry)

d11<-subset(cctry, month>=9)
head(d11)
ag<-aggregate(d11$PIT, by=list(d11$hour, d11$date), FUN=length)
ag1<-aggregate(ag$x, by=list(ag$Group.1), FUN=mean)
ag
ag1
unique(cctry$PIT)

xyplot(x~Group.1, ag1,)

head(rt)
names(rt) <- c("NA","species","PIT","month","count", "date")
rt %>%
group_by(hour, day) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)
head(test)

head(test)
as.factor(test$day)->test$day
subset(test, species =="Ccarp") -> cc

xyplot(count ~ hour, test, xlab="hour",cex=0.5,auto.key=TRUE, ylab="count")



#### thenn to do radiotag fish with above sort ######

write.csv(cc, file="cctry")
cctry <-read.csv("cctry") 

head(cctry)
subset(cctry, PIT>="611068" & PIT<="61199" & day>="10" & day<="25") -> rt
rt

xyplot(hour ~ day, rt ,group=PIT,auto.key = TRUE, xlab="PIT", ylab="HOUR", jitter.data = TRUE)


strip.default




######## fish per hour per day ---- see number of days fish were read at an hour #######

total %>%
group_by(Species, HOUR) %>%
summarize(n_distinct (DAY)) -> test
test %>% print(n=101)
names(test) <- c("species" ,"hour","count")
head(test)








########## whooshh carp #############
library(dplyr)

all<-read.csv("kens_working_all.csv")
head(all)


pit1 <-read.csv("corn_sort.csv") 
pit2 <-read.csv("Whooshh_tags_all.csv") 
pit3 <-read.csv("RCWD PIT tags.csv") 
head(pit1)
head(pit)
total<- merge(all, pit1, pit2, pit3,  by="PIT")
head(total)

total %>%
group_by(Species,MONTH, DAY) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)

head(test)

names(test) <- c("species" ,"month", "day","count")
head(test)

subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg

head(cc)

library(lattice)



###CARP by day

xyplot(count ~ day, cc, ,auto.key = TRUE, xlab="Day", ylab="Count")


####### WHOOOSH CARPby hour###########



library(dplyr)

all<-read.csv("kens_working_all.csv")
head(all)
pit <-read.csv("Whooshh_tags_all.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)




head(total)


total %>%
group_by(Species,PIT, MONTH, HOUR, DAY) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)

head(test)

names(test) <- c("species" ,"PIT","month", "hour","day","count")
head(test)

subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg
cc
subset(cc, day =>10) -> cc2

cc
library(lattice)


###CARP by hour
xyplot(hour ~ PIT, cc ,auto.key = TRUE, xlab="PIT", ylab="HOUR")


####################################################################################################################################################################################################################################################################################################################

########### adding whooshh + summer + solutions ########



library(dplyr)
library(gtools)
library(lattice)
all<-read.csv("kens_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
pit2 <-read.csv("Whooshh_tags_all.csv") 
pit3 <-read.csv("RCWD PIT tags.csv") 
smartbind(pit,pit2,pit3) -> allp
total<- merge(all, allp,  by="PIT")
head(total)

unique(allp$PIT)


total %>%
group_by(Species, MONTH, DATE, PIT) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)

head(test)
as.Date(test$DATE, "%m/%d/%y") -> test$DATE
names(test) <- c("species", "month", "date", "pit","count")
head(test)

test %>%
group_by(species, date) %>%
summarize(n_distinct (pit)) -> test2
test2%>% print(n=2000)
names(test2) <- c("species" ,"date", "count")



xyplot(count ~ date,test2, group=species, xlab="Date", ylab="Daily Unique Count", main="allspecies", auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)




xyplot((log10(count)+1) ~ date,test2, group=species, xlab="Date",ylab="LOG Daily Unique Count", main="all",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)



####### by day  ###########



head(total)
unique(cc)

total %>%
group_by(Species,MONTH, DAY) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)

head(test)

names(test) <- c("species" ,"month", "day","count")
head(test)

subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg



library(lattice)
head(cc)
subset(cc,  month==9,day>=1 & day<=23) -> cc
cc$day
###CARP by day
xyplot(count ~ day, cc, ,auto.key = TRUE, xlab="Day", ylab="Count")



####### by hour###########



head(total)


total %>%
group_by(Species,PIT, MONTH, HOUR, DAY) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)

head(test)

names(test) <- c("species" ,"PIT","month", "hour","day","count")
head(test)

subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg

library(lattice)


###CARP by hour
xyplot(hour ~ PIT, cc ,auto.key = TRUE, xlab="PIT", ylab="HOUR",jitter.data = TRUE, factor=5)

###yellow bullhead by hour
xyplot(count ~ hour, yb, group=day ,auto.key = TRUE, xlab="Day", ylab="Count")

###bluegill per hour
xyplot(count ~ hour, bg, group=day ,auto.key = TRUE, xlab="Day", ylab="Count")




##### by hour per indvidual #####
write.csv(cc, file="cctry")
cctry <-read.csv("cctry") 

head(cctry)
subset(cctry,  day>=11 & day<=23) -> rt
head(rt)
as.factor(rt$PIT)->rt$PIT
xyplot(day ~ hour|PIT, rt, xlab="hour",cex=0.5, auto.key=TRUE, xlim=c(-1,24), ylab="day",ylim=c(9,24),layout=c(5,5))
summary(rt)

################## mean number of PIT per hour across all days since baiting began
head(cctry)

d11<-subset(cctry, day>10 & day<23)

ag<-aggregate(d11$PIT, by=list(d11$hour, d11$day), FUN=length)
ag1<-aggregate(ag$x, by=list(ag$Group.1), FUN=mean)
ag
ag1
unique(cctry$PIT)

xyplot(x~Group.1, ag1,)



rt %>%
group_by(hour, day) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)
head(test)
names(test) <- c("hour","day","count")
head(test)
as.factor(test$day)->test$day
xyplot(count ~ hour|day, test, xlab="hour",cex=0.5,auto.key=TRUE, ylab="count")





####################################################################################################################################################################################################################################################################################################################################################
##################################
						CONTROL SITE ########################################################################################################################################


####### number of days pit tags were at site  ###########

all<-read.csv("johns_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)

library(dplyr)
library(lattice)

head(total)


total %>%
group_by(Species, DATE, PIT) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)


names(test) <- c("species","date", "pit","count")

as.Date(test$date, "%m/%d/%Y") -> test$date


test %>%
group_by(species, date) %>%
summarize(n_distinct (pit)) -> test2
test2%>% print(n=200)
names(test2) <- c("species" ,"date", "count")
head(test2)




xyplot((log10(count)+1) ~ date,test2, group=species, xlab="Date",ylab="Daily Unique Count", main="johns",par.settings = list(superpose.symbol = list(col = 1:15, pch = 16:25)), auto.key = TRUE, jitter.y=TRUE, factor=0.3, jitter.x=TRUE)




subset(test, species =="Ccarp") -> cc
subset(test, species =="B_Bullhead") -> bb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg
subset(test, species =="LMB") -> lmb


cc %>%
group_by(species) %>%
summarize(n_distinct (pit)) -> cc2
cc2 %>% print(n=1000)

ws
bb %>%
group_by(species) %>%
summarize(n_distinct (pit)) -> bb2
bb2 %>% print(n=1000)

ws %>%
group_by(species) %>%
summarize(n_distinct (pit)) -> ws2
ws2 %>% print(n=1000)

bg %>%
group_by(species) %>%
summarize(n_distinct (pit)) -> bg2
bg2 %>% print(n=1000)





######################

control vs treatment who showed up at both???
########################################################################################
all<-read.csv("kens_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")

all<-read.csv("johns_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
head(pit)
total2<- merge(all, pit,  by="PIT")
head(total2)
head(total)

total %>%
group_by(PIT, Species) %>%
summarize(n_distinct (DAY)) -> test
test%>% print(n=200)

names(test) <- c("pit","species" ,"count")
xyplot(count ~ pit|Species, test,auto.key = TRUE, xlab="Day", ylab="Count", xlim=(5:20)



total2 %>%
group_by(PIT, Species) %>%
summarize(n_distinct (DAY)) -> test2
test2%>% print(n=200)
head(test2)


setdiff(test2$PIT, test$PIT) ->z

z




####### by day  ###########

all<-read.csv("johns_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)

library(dplyr)


head(total)
unique(cc)

total %>%
group_by(Species,MONTH, DAY, PIT) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)

head(test)

names(test) <- c("species" ,"month", "day","count")
head(test)

library(lattice)

subset(test,  day>=1 & day<=23) -> allspecies

###all psecies by day
xyplot(count ~ day|species, allspecies ,auto.key = TRUE, xlab="Day", ylab="Count")

###yellow bullhead by day
xyplot(count ~ day, yb, group=day ,auto.key = TRUE, xlab="Day", ylab="Count")

###bluegill per day
xyplot(count ~ day, bg, group=day ,auto.key = TRUE, xlab="Day", ylab="Count")

###white sucker per day 
xyplot(count ~ day, ws, group=day ,auto.key = TRUE, xlab="Day", ylab="Count")




####### by hour###########



library(dplyr)

all<-read.csv("johns_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)




head(total)


total %>%
group_by(Species,PIT, MONTH, HOUR, DAY) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)

head(test)

names(test) <- c("species" ,"PIT","month", "hour","day","count")
head(test)

subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg

library(lattice)


###CARP by hour
xyplot(hour ~ PIT, cc ,auto.key = TRUE, xlab="PIT", ylab="HOUR",jitter.data = TRUE, factor=5)

###yellow bullhead by hour
xyplot(count ~ hour, yb, group=day ,auto.key = TRUE, xlab="Day", ylab="Count")

###bluegill per hour
xyplot(count ~ hour, bg, group=day ,auto.key = TRUE, xlab="Day", ylab="Count")




##### by hour per indvidual #####
write.csv(cc, file="cctry")
cctry <-read.csv("cctry") 

head(cctry)
subset(cctry,  day>=11 & day<=23) -> rt
head(rt)
as.factor(rt$PIT)->rt$PIT
xyplot(day ~ hour|PIT, rt, xlab="hour",cex=0.5, auto.key=TRUE, xlim=c(-1,24), ylab="day",ylim=c(9,24),layout=c(5,5))
summary(rt)

################## mean number of PIT per hour across all days since baiting began
head(cctry)

d11<-subset(cctry, day>10 & day<23)

ag<-aggregate(d11$PIT, by=list(d11$hour, d11$day), FUN=length)
ag1<-aggregate(ag$x, by=list(ag$Group.1), FUN=mean)
ag
ag1
unique(cctry$PIT)

xyplot(x~Group.1, ag1,)



rt %>%
group_by(hour, day) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)
head(test)
names(test) <- c("hour","day","count")
head(test)
as.Date(cc$date, "%m/%d/%Y") -> cc$date

xyplot(count ~ hour|day, test, xlab="hour",cex=0.5,auto.key=TRUE, ylab="count")



#### thenn to do radiotag fish with above sort ######

write.csv(cc, file="cctry")
cctry <-read.csv("cctry") 

head(cctry)
subset(cctry, PIT>="611068" & PIT<="61199" & day>="10" & day<="19") -> rt
rt

xyplot(hour ~ day, rt ,group=PIT,auto.key = TRUE, xlab="PIT", ylab="HOUR", jitter.data = TRUE)


strip.default




######## fish per hour per day ---- see number of days fish were read at an hour #######

total %>%
group_by(Species, HOUR) %>%
summarize(n_distinct (DAY)) -> test
test %>% print(n=101)
names(test) <- c("species" ,"hour","count")
head(test)








########## whooshh carp #############
library(dplyr)

all<-read.csv("kens_working_all.csv")
head(all)


pit1 <-read.csv("corn_sort.csv") 
pit2 <-read.csv("Whooshh_tags_all.csv") 
pit3 <-read.csv("RCWD PIT tags.csv") 
head(pit1)
head(pit)
total<- merge(all, pit1, pit2, pit3,  by="PIT")
head(total)

total %>%
group_by(Species,MONTH, DAY) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)

head(test)

names(test) <- c("species" ,"month", "day","count")
head(test)

subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg

head(cc)

library(lattice)



###CARP by day

xyplot(count ~ day, cc, ,auto.key = TRUE, xlab="Day", ylab="Count")


####### WHOOOSH CARPby hour###########



library(dplyr)

all<-read.csv("kens_working_all.csv")
head(all)
pit <-read.csv("Whooshh_tags_all.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)




head(total)


total %>%
group_by(Species,PIT, MONTH, HOUR, DAY) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)

head(test)

names(test) <- c("species" ,"PIT","month", "hour","day","count")
head(test)

subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg
cc
subset(cc, day =>10) -> cc2

cc
library(lattice)


###CARP by hour
xyplot(hour ~ PIT, cc ,auto.key = TRUE, xlab="PIT", ylab="HOUR")




########### adding whooshh + summer + solutions ########
all<-read.csv("kens_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
pit2 <-read.csv("Whooshh_tags_all.csv") 
pit3 <-read.csv("RCWD PIT tags.csv") 


total<- merge(all, pit,  by="PIT")
total2 <- merge(total,pit2, by="PIT")
total3 <- merge(total2,pit3, by="PIT")

head(total3)





			EXPERIMENTAL SITE       

####### number of days pit tags were at site  ###########

all<-read.csv("kens_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)

library(dplyr)


head(total)


total %>%
group_by(Species,MONTH, DAY, PIT) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)

head(test)

names(test) <- c("species" ,"month", "day", "pit","count")
head(test)

subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg

cc %>%
group_by(pit) %>%
summarize(n_distinct (day)) -> test
test %>% print(n=200)

names(test) <- c("pit" ,"count")

xyplot(count ~ pit, test ,auto.key = TRUE, xlab="Day", ylab="Count")






####### by day  ###########

all<-read.csv("kens_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)

library(dplyr)


head(total)
unique(cc)

total %>%
group_by(Species,MONTH, DAY) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)

head(test)

names(test) <- c("species" ,"month", "day","count")
head(test)

subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg



library(lattice)

subset(cc,  day>=1 & day<=23) -> cc

###CARP by day
xyplot(count ~ day, cc, ,auto.key = TRUE, xlab="Day", ylab="Count")

###yellow bullhead by day
xyplot(count ~ day, yb, group=day ,auto.key = TRUE, xlab="Day", ylab="Count")

###bluegill per day
xyplot(count ~ day, bg, group=day ,auto.key = TRUE, xlab="Day", ylab="Count")

###white sucker per day 
xyplot(count ~ day, ws, group=day ,auto.key = TRUE, xlab="Day", ylab="Count")




####### by hour###########



library(dplyr)

all<-read.csv("kens_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)




head(total)


total %>%
group_by(Species,PIT, MONTH, HOUR, DAY) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)

head(test)

names(test) <- c("species" ,"PIT","month", "hour","day","count")
head(test)

subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg

library(lattice)


###CARP by hour
xyplot(hour ~ PIT, cc ,auto.key = TRUE, xlab="PIT", ylab="HOUR",jitter.data = TRUE, factor=5)

###yellow bullhead by hour
xyplot(count ~ hour, yb, group=day ,auto.key = TRUE, xlab="Day", ylab="Count")

###bluegill per hour
xyplot(count ~ hour, bg, group=day ,auto.key = TRUE, xlab="Day", ylab="Count")




##### by hour per indvidual #####
write.csv(cc, file="cctry")
cctry <-read.csv("cctry") 

head(cctry)
subset(cctry,  day>=11 & day<=23) -> rt
head(rt)
as.factor(rt$PIT)->rt$PIT
xyplot(day ~ hour|PIT, rt, xlab="hour",cex=0.5, auto.key=TRUE, xlim=c(-1,24), ylab="day",ylim=c(9,24),layout=c(5,5))
summary(rt)

################## mean number of PIT per hour across all days since baiting began
head(cctry)

d11<-subset(cctry, day>10 & day<23)

ag<-aggregate(d11$PIT, by=list(d11$hour, d11$day), FUN=length)
ag1<-aggregate(ag$x, by=list(ag$Group.1), FUN=mean)
ag
ag1
unique(cctry$PIT)

xyplot(x~Group.1, ag1,)



rt %>%
group_by(hour, day) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)
head(test)
names(test) <- c("hour","day","count")
head(test)
as.factor(test$day)->test$day
xyplot(count ~ hour|day, test, xlab="hour",cex=0.5,auto.key=TRUE, ylab="count")



#### thenn to do radiotag fish with above sort ######

write.csv(cc, file="cctry")
cctry <-read.csv("cctry") 

head(cctry)
subset(cctry, PIT>="611068" & PIT<="61199" & day>="10" & day<="19") -> rt
rt

xyplot(hour ~ day, rt ,group=PIT,auto.key = TRUE, xlab="PIT", ylab="HOUR", jitter.data = TRUE)


strip.default




######## fish per hour per day ---- see number of days fish were read at an hour #######

total %>%
group_by(Species, HOUR) %>%
summarize(n_distinct (DAY)) -> test
test %>% print(n=101)
names(test) <- c("species" ,"hour","count")
head(test)








########## whooshh carp #############
library(dplyr)

all<-read.csv("kens_working_all.csv")
head(all)


pit1 <-read.csv("corn_sort.csv") 
pit2 <-read.csv("Whooshh_tags_all.csv") 
pit3 <-read.csv("RCWD PIT tags.csv") 
head(pit1)
head(pit)
total<- merge(all, pit1, pit2, pit3,  by="PIT")
head(total)

total %>%
group_by(Species,MONTH, DAY) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)

head(test)

names(test) <- c("species" ,"month", "day","count")
head(test)

subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg

head(cc)

library(lattice)



###CARP by day

xyplot(count ~ day, cc, ,auto.key = TRUE, xlab="Day", ylab="Count")


####### WHOOOSH CARPby hour###########



library(dplyr)

all<-read.csv("kens_working_all.csv")
head(all)
pit <-read.csv("Whooshh_tags_all.csv") 
head(pit)
total<- merge(all, pit,  by="PIT")
head(total)




head(total)


total %>%
group_by(Species,PIT, MONTH, HOUR, DAY) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=101)

head(test)

names(test) <- c("species" ,"PIT","month", "hour","day","count")
head(test)

subset(test, species =="Ccarp") -> cc
subset(test, species =="Y_Bullhead") -> yb
subset(test, species =="WS") -> ws
subset(test, species =="BLU") -> bg
cc
subset(cc, day =>10) -> cc2

cc
library(lattice)


###CARP by hour
xyplot(hour ~ PIT, cc ,auto.key = TRUE, xlab="PIT", ylab="HOUR")




########### adding whooshh + summer + solutions ########

all<-read.csv("kens_working_all.csv")
head(all)
pit <-read.csv("corn_sort.csv") 
pit2 <-read.csv("Whooshh_tags_all.csv") 
pit3 <-read.csv("RCWD PIT tags.csv") 


total<- merge(all, pit,  by="PIT")
total2 <- merge(total,pit2, by="PIT")
total3 <- merge(total2,pit3, by="PIT")

head(total3)








################################################################################################################################################################################################################################################################################################################################################################################################################## corn as attractant???? NEWEST TRY  ###### #######################################################################################################################################################################################################################################################################################################



######### PIT TAGS ###########

pit <-read.csv("Pit_Tags.csv") 
options(scipen = 999)
head(pit, n=20)







###### now I need to merge PIT with Antenna_data to eliminate Junk and match species with tags #####
all$Antenna<-NULL
pit$Antenna<-NULL
str(pit)
str(all)
total[which(total$Species=="Common carp" & total$Pond==7 & total$date ==9),]
total[which(total$Species=="Common carp" & total$Pond==7),]

all$PIT<-as.character(all$PIT)
all[which(all$PIT %in% pit$PIT),] -> df


total<- merge(all, pit,  by="PIT", all.y=TRUE, na.rm=TRUE)
head(total)
write.csv(total, file="test4")
df$PIT<-as.character(df$PIT)
head(df)





total$Year<-NULL
total$Min<-NULL
total$Detection<-NULL
total$Antenna.x<-NULL
total$Antenna.y<-NULL
head(total, n=10)
names(total) <- c("PIT", "Month", "Day","Hour", "Count", "Date","Species", "Pond" )
head(total, n=10)






#### use dplyr to sort ########

library("dplyr") 
library(lattice)

##### attractatn test ######


total %>%
group_by(Pond,Day, Month, PIT, Species) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=20)

subset(test, Species =="Common carp") -> ccpit2
subset(test, Species =="Yellow Perch") -> yppit2
subset(test, Species =="White Sucker") -> wspit2
subset(test, Species =="Bluegill") -> bgpit2


xyplot(PIT~ Day, ccpit2, group=Species, auto.key = TRUE, xlab="Hour", ylab="Count")
xyplot(PIT~Day, yppit2, group=Species, auto.key = TRUE, xlab="Hour", ylab="Count")
xyplot(PIT ~ Day, wspit2, group=Species, auto.key = TRUE, xlab="Hour", ylab="Count")
xyplot(PIT ~ Day, bgpit2, group=Species, auto.key = TRUE, xlab="Hour", ylab="Count")






total %>%
group_by(date, Pond, Species, PIT) %>%
summarize(n_distinct (date))%>%as.data.frame -> test
head(total)


subset(total, Species =="Common carp") -> cc
subset(total, Species =="Yellow Perch") -> yp
subset(total, Species =="White Sucker") -> ws
subset(total, Species =="Bluegill") -> bg

head(cc)

cc %>%
group_by(Month, Day, Pond, Species, PIT) %>%
summarize(n_distinct (PIT))%>%as.data.frame -> test1
head(test1)

xyplot(Day~, test1,group=PIT, auto.key = TRUE, xlab="DAY", ylab="Count")








##### can still use this is what Jean worked on me with ####
###### of distinct reads per day

total %>%
group_by(Pond,Day, Month, Hour, Species) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=20)



names(test) <- c("Pond", "Day", "Month","Hour","Species",  "Count" )
test$NewCount<-0
head(test)
read.csv("hours.csv")->hours
tail(total2)
total2<-merge(hours,test, by="Hour" )
print(subset(total2, Pond==6 & Hour=="NA"))
test$NewCount1<-ifelse(test$Count>0,test$Count,0)



test$Hour<-as.integer(test$Hour)

head(test)
head(hours)
full_join(hours,test, by="Hour") -> abc
head(abc)
print(subset(total2, Pond==6 & Hour=="NA"))
abc


########### total read #########
total %>%
group_by(PIT, Antenna, Species) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=200)

write.csv(test, file="all_read")


################# finding unread tags
pit57 <-read.csv("Pit_Tags5_7.csv") 
pit1012 <-read.csv("Pit_Tags10_12.csv") 


setdiff(pit1012$PIT, w10_12$PIT) -> notused
head(notused)
as.data.frame(notused)->notused
names(notused) <- c("PIT")
notused
try<- merge(pit, notused,  by="PIT", all.y=TRUE, na.rm=TRUE)
head(try)

setdiff(pit57$PIT, w5_7$PIT) -> notused2
head(notused2)
as.data.frame(notused2)->notused2
names(notused2) <- c("PIT")
notused2
try2<- merge(pit, notused2,  by="PIT", all.y=TRUE, na.rm=TRUE)
write.csv(try2, file = "notused2")
try2$PIT

head(w5_7)

####first last occurrence all ######

total$date <- paste(total$Month,total$Day,sep = "")
head(total)
first_last <- total %>% group_by(PIT) %>% summarise(first_read = min(date), last_read = max(date))
first_last %>% print(n=900)


when<- merge(first_last,pit,  by="PIT", all.y=TRUE, na.rm=TRUE)
head(when)
write.csv(when, file = "first_last_all")



###### finding unread tags
library(dplyr)

total %>%
group_by(Pond, Date, Hour, Species) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=30)

write.csv(test, file="try")

names(test) <- c("pond" , "date", "hour" , "species","count")
head(test)

subset(test, species =="Common carp") -> cc
subset(test, species =="Yellow Perch") -> yp
subset(test, species =="White Sucker") -> ws
subset(test, species =="Bluegill") -> bg

write.csv(cc, file="cctry")
write.csv(yp, file="yptry")
write.csv(ws, file="wstry")
write.csv(bg, file="bgtry")

library(lattice)
xyplot(subset(cc, date<7)$count~subset(cc, date<7)$hour, cc, groups=pond)
head(cc, n=100)
cc %>% print(n=200)


total %>%
group_by(Pond, Date, Species) %>%
summarize(n_distinct (PIT)) -> test
test %>% print(n=30)
write.csv(test, file="all_date")

