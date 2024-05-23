library(ggplot2)

# Load NEI and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI data to get motor vehicle emissions portion
vehicles <- grepl("vehicle", SCC$SCC.Level.Two, ignore.case = TRUE)
vehicles.SCC <- SCC[vehicles,]$SCC
vehicles.NEI <- NEI[NEI$SCC %in% vehicles.SCC,]

# Subset the Baltimore portion of the vehicles.NEI data (fips = 24510)
Bmore.vehicle.NEI <- vehicles.NEI[vehicles.NEI$fips=="24510",]

# Plot Baltimore City Vehicle Emissions from 1999 - 2008
ggplot(Bmore.vehicle.NEI, aes(factor(year), Emissions)) +
  geom_bar(stat = "identity", fill = "blue") +
  labs(x="Year", y="2.5 PM Emissions (Tons)", title = "Baltimore City Motor Vehicle Emissions 1999 - 2008")
# Save PNG image file
dev.copy(png, filename = "Plot5.png", width = 480, height = 480)
dev.off()
