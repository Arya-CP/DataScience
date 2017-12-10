#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

#Subsetting 'NEI' dataset To check the total emissions from PM2.5 decreased in the Baltimore City from various sources

subsetNEI <- NEI[NEI$fips=="24510", ]
Totalemissions.baltimore <- aggregate(Emissions ~ year + type, subsetNEI, sum)

# Create BarPlot and Export as PNG file

png("plot3.png")

ggplot(subsetNEI,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by various Source Type"))

dev.off()

