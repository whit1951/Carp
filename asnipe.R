#' Explore asnipe package functions
#' May 29, 2020
#' Lauren White, lwhite@sesync.org

library(asnipe)

data("group_by_individual")
str(gbi) # see the structure of the data

## Calculate group membership using time window
data("identified_individuals")

## calculate group_by_individual for first day at one location
group_by_individual <- get_associations_points_tw(identified_individuals, time_window=180,
                                                  which_days=1,which_locations="1B")
## split the resulting list
times <- group_by_individual[[2]]
locations <- group_by_individual[[3]]
group_by_individual <- group_by_individual[[1]]

#' Convert group or individual data into a group by individual matrix
#' Converts several different types of data storage into a group by individual matrix for calculating or permuting networks
## define group memberships (these would be read from a file)
individuals <- data.frame(ID=c("C695905","H300253","H300253",
                               "H300283","H839876","F464557","H300296","H300253",
                               "F464557","H300296","C695905","H300283","H839876"),
                          GROUP=c(1,1,2,2,2,3,3,4,5,5,6,6,6))
## create a time column
individuals <- cbind(individuals,
                     DAY=c(1,1,1,1,1,2,2,2,3,3,3,3,3))
head(individuals)
gbi <- get_group_by_individual(individuals,
                               data_format="individuals")
## define group memberships (these would be read from a file)
groups <- list(G1=c("C695905","H300253"),
               G2=c("H300253","H300283","H839876"),
               G3=c("F464557","H300296"),
               G4=c("H300253"),
               G5=c("F464557","H300296"),
               G6=c("C695905","H300283","H839876"))
## create a time variable
days <- c(1,1,2,2,3,3)
head(groups)
gbi <- get_group_by_individual(groups,data_format="groups")
gbi

#' Gaussian mixed model approach for group by individual
data("identified_individuals")
head(identified_individuals)
# Create unique locations in time
identified_individuals$Loc_date <-
  paste(identified_individuals$Location,
        identified_individuals$Date,sep="_")
head(identified_individuals)

# Provide global identity list (including individuals
# not found in these data, but that need to be included).
# Not including this will generate gbi with only the
# individuals provided in the data set (in this case 151
# individuals)
global_ids <- levels(identified_individuals$ID)
# Generate GMM data
gmm_data <- gmmevents(time=identified_individuals$Time,
                      identity=identified_individuals$ID,
                      location=identified_individuals$Loc_date,
                      global_ids=global_ids)
# Extract output
gbi <- gmm_data$gbi
events <- gmm_data$metadata
observations_per_event <- gmm_data$B
# Can also subset gbi to only individuals observed
# in the dataset to give same answer as if
# global_ids had not been provided
gbi <- gbi[,which(colSums(gbi)>0)]

# Split up location and date data
tmp <- strsplit(events$Location,"_")
tmp <- do.call("rbind",tmp)
events$Location <- tmp[,1]
events$Date <- tmp[,2]

head(br_corn)
br_corn<-br_corn[order(br_corn$DATETIME),] #order chronologically
Time<-vector(mode="integer", length=nrow(br_corn)) #initialize empty vectors for numeric date and time
Date<-vector(mode="integer", length=nrow(br_corn))
for(i in 1:nrow(br_corn)){
  Time[i]<-as.integer(difftime(br_corn$DATETIME[i],br_corn$DATETIME[1],units='secs'))
  Date[i]<-as.integer(difftime(br_corn$DATETIME[i],br_corn$DATETIME[1],units='days'))
}
identified_individuals<-data.frame(Date=Date, Time=Time, ID=br_corn$PIT, Location=br_corn$Antenna)
identified_individuals$Loc_date <-
  paste(identified_individuals$Location,
        identified_individuals$Date,sep="_")
head(identified_individuals)

global_ids <- levels(identified_individuals$ID)

# Generate GMM data
start.time <- Sys.time()

gmm_data <- gmmevents(time=identified_individuals$Time,
                      identity=identified_individuals$ID,
                      location=identified_individuals$Loc_date,
                      global_ids=global_ids)
end.time <- Sys.time()
time.taken <- end.time - start.time
time.taken

# Extract output
gbi <- gmm_data$gbi
events <- gmm_data$metadata
observations_per_event <- gmm_data$B
hist(rowSums(gbi)) #larger shoaling events are rare
# Can also subset gbi to only individuals observed
# in the dataset to give same answer as if
# global_ids had not been provided
gbi <- gbi[,which(colSums(gbi)>0)]
dim(gbi)

# Split up location and date data
tmp <- strsplit(events$Location,"_")
tmp <- do.call("rbind",tmp)
events$Location <- tmp[,1]
events$Date <- tmp[,2]
events$midpoint<-(events$Start-events$End)/2+events$Start #equivalent to "times" in example
# times<-events$midpoint
# names(times)<-1:length(times)
head(events)

#Convert to a network

# data("group_by_individual")
# data("times")
# subset GBI (to reduce run time of the example)
# gbi <- gbi[1:80,]
# events<-events[1:80,]
## define to 2 x N x N network to hold two association matrices
networks <- array(0, c(2, ncol(gbi), ncol(gbi)))
## calculate network for first half of the time
networks[1,,] <- get_network(gbi, data_format="GBI",
                             association_index="SRI", times=events$midpoint, start_time=min(events$midpoint),
                             end_time=max(events$midpoint))
networks[2,,] <- get_network(gbi, data_format="GBI",
                             association_index="HWI", times=events$midpoint, start_time=min(events$midpoint),
                             end_time=max(events$midpoint))
library(igraph)
net <- graph.adjacency(networks[1,,], mode="undirected", diag=FALSE, weighted=TRUE)
deg_weighted <- graph.strength(net)
hist(deg_weighted)
plot(net)

net2 <- graph.adjacency(networks[2,,], mode="undirected", diag=FALSE, weighted=TRUE)
deg_weighted2 <- graph.strength(net2)
hist(deg_weighted2)
plot(net2)
detach(package:igraph)


### Try using asnipe package data
data("group_by_individual")
data("times")
# subset GBI (to reduce run time of the example)
gbi <- gbi[,1:80]
## define to 2 x N x N network to hold two association matrices
networks <- array(0, c(2, ncol(gbi), ncol(gbi)))
## calculate network for first half of the time
networks[1,,] <- get_network(gbi, data_format="GBI",
                             association_index="SRI", times=times, start_time=0,
                             end_time=max(times)/2)
networks[2,,] <- get_network(gbi, data_format="GBI",
                             association_index="SRI", times=times,
                             start_time=max(times)/2, end_time=max(times))
## test if one predicts the other via a mantel test (must be loaded externally)
library(ape)
mantel.test(networks[1,,],networks[2,,])
## convert to igraph network and calculate degree of the first network
## Not run:
library(igraph)
net <- graph.adjacency(networks[1,,], mode="undirected", diag=FALSE, weighted=TRUE)
deg_weighted <- graph.strength(net)
detach(package:igraph)
## alternatively package SNA can use matrix stacks directly
library(sna)
deg_weighted <- degree(networks,gmode="graph", g=c(1,2), ignore.eval=FALSE)
detach(package:sna)

### Lagged association rate
data("group_by_individual")
data("times")
data("individuals")

## calculate lagged association rate for great tits
lagged_rates <- LAR(gbi,times,3600, classes=inds$SPECIES, which_classes="GRETI")
## plot the results
plot(lagged_rates, type='l', axes=FALSE, xlab="Time (hours)", ylab="LAR", ylim=c(0,1))
axis(2)
axis(1, at=lagged_rates[,1], labels=c(1:nrow(lagged_rates)))

## dyadic lagged association rate
data("group_by_individual")
data("times")
data("individuals")
## calculate lagged association rate
lagged_rates <- LRA(gbi,times,3600, classes=inds$SPECIES, which_classes="GRETI", output_style=2)
