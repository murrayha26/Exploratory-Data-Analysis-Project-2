
library(ggplot2)

# Load NEI and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Subset NEI data to get coal combustion portion
combustion.sources <- grepl("combustion", SCC$SCC.Level.One, ignore.case = TRUE)
coal.related <- grepl("coal", SCC$SCC.Level.Four, ignore.case = TRUE)

#Identify cases where combustion was related to coal (True for both)
coal.combustion <- (combustion.sources & coal.related)
SCC.combustion <- SCC[combustion.sources,]$SCC
NEI.combustion <- NEI[NEI$SCC %in% SCC.combustion,]

# Plot U.S Emissions from Coal Combustion from 1999 - 2008
ggplot(NEI.combustion, aes(factor(year), Emissions/10^5)) +
  geom_bar(stat = "identity") +
  labs(x = "Year", y = "Total 2.5 PM Emissions (10^5 Tons)", title = "U.S. 2.5 PM Coal Combustion Source Emissions 1999 - 2008")

# Save PNG image file
dev.copy(png, filename = "Plot4.png", width = 480, height = 480)
dev.off()
