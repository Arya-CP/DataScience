#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

#Subsetting 'NEI' dataset To check the total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008

subsetNEI <- NEI[NEI$fips=="24510", ]
Totalemissions.baltimore <- aggregate(Emissions ~ year, subsetNEI, sum)
colrs <- c("red", "brown", "green", "yellow")

# Create BarPlot and Export as PNG file

png('plot2.png')

barplot(height=Totalemissions.baltimore$Emissions, names.arg=Totalemissions.baltimore$year,xlab="years", ylab=expression('total PM'[2.5]*' emission'), main=expression('Total PM'[2.5]*' in Baltimore City-MD emissions at various years'),col=colrs)                                                       
dev.off()

