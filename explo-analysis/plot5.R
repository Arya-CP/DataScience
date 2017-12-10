#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

# merge the two data sets 
if(!exists("NEISCC")){
  NEISCC <- merge(NEI, SCC, by="SCC")
}

#Suset NEI data

subsetNEI <- NEI[NEI$fips=="24510" & NEI$type=="ON-ROAD",  ]

vehiclemissions <- aggregate(Emissions ~ year, subsetNEI, sum)

# Create BarPlot and Export as PNG file

png("plot4.png")

ggplot(vehiclemissions,aes(x = factor(year),y = Emissions)) +
  geom_bar(stat="identity", fill ="#FF9999", width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emissions")) + 
  labs(title=expression("PM"[2.5]*"Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

dev.off()

