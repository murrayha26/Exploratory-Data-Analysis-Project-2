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
# Add city name
Bmore.vehicle.NEI$city <- "Baltimore City"

# Repeat subsetting for Los Angeles (fips = 06037)
LA.vehicle.NEI <- vehicles.NEI[vehicles.NEI$fips=="06037",]
# Add city name
LA.vehicle.NEI$city <- "Los Angeles County"

# Combine Baltimore and LA County subsets
combinedNEI <- rbind(Bmore.vehicle.NEI, LA.vehicle.NEI)

# Plot Baltimore City and LA County Vehicle Emissions from 1999 - 2008 for comparison via facets
ggplot(combinedNEI, aes(x=factor(year), Emissions, fill = city)) +
  geom_bar(stat = "identity") +
  facet_grid(~city) +
  labs(x="Year", y="2.5 PM Emissions (Tons)", title = "2.5 PM Baltimore City and Los Angeles County Motor Vehicle Emissions 1999-2008")

# Save PNG image file
dev.copy(png, filename = "Plot6.png", width = 480, height = 480)
dev.off()
