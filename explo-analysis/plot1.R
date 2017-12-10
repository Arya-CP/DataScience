getwd()
#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Grouping total emmissions by year

aggregatedTotalByYear <- aggregate(Emissions ~ year, NEI, sum)

colrs <- c("red", "brown", "green", "yellow")

# Create BarPlot and Export as PNG file

png('plot1.png')

barplot(height=aggregatedTotalByYear$Emissions/1000, names.arg=aggregatedTotalByYear$year,xlab="years", ylab=expression('total PM'[2.5]*' emission'), main=expression('Total PM'[2.5]*' emissions at various years'),col=colrs)                                                       
dev.off()
