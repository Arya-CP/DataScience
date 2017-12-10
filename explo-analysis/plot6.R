#Load data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

library(ggplot2)

vehicles <- grepl(pattern = "vehicle",x = SCC$SCC.Level.Two,ignore.case = TRUE)
vehiclesSCC <- SCC[vehicles,]$SCC
vehiclesNEI <- NEI[NEI$SCC %in% vehiclesSCC,]

# Filter vehicles based Baltimore and LA and update the observations 

filteredvehicles <- (vehiclesNEI[vehiclesNEI$fips == "24510" | vehiclesNEI$fips == "06037",])
filteredvehicles[,1] <- as.factor(x = filteredvehicles[,1])
filteredvehicles <- filteredvehicles
levels(filteredvehicles$fips)[levels(filteredvehicles$fips)=="06037"] <- "Los Angeles county "
levels(filteredvehicles$fips)[levels(filteredvehicles$fips)=="24510"] <- "Baltimore City"

# Create BarPlot and Export as PNG file

png(filename = "plot6.png",width = 480, height = 480,units = "px")

g <- ggplot(data = filteredvehicles, aes(factor(year), Emissions)) +
  geom_bar(stat = "identity",fill = "grey", width = 0.75) + 
  facet_grid(facets = .~fips,scales = "free", space = "free") +
  theme_grey(base_size = 14,base_family = "") +
  labs(x="Year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Emissions in  LA and Baltimore"))

print(g)
dev.off()
