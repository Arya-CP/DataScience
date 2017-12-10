#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

#Merge the two data sets

if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

#Subset coal related data

coalMatches  <- grepl("coal", NEISCC$Short.Name, ignore.case=TRUE)
subsetNEISCC <- NEISCC[coalMatches, ]

coalemissions <- aggregate(Emissions ~ year , subsetNEISCC, sum)

# Create BarPlot and Export as PNG file

png("plot4.png")

ggplot(coalemissions,aes(x = factor(year),y = Emissions/10^5)) +
  geom_bar(stat="identity", fill ="#FF9999", width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emissions)")) + 
  labs(title=expression("PM"[2.5]*" Coal Combustion-Related Sources"))

dev.off()

