
# Load NEI and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Pull the subset of data pertaining to Baltimore (fip = 24510)
BaltimoreNEI <- NEI[NEI$fips=="24510",]

# Sum total Baltimore emission by year
Baltimore.Annual.Totals <- aggregate(Emissions ~ year, BaltimoreNEI, sum)

barplot(Baltimore.Annual.Totals$Emissions/10^3, names.arg = annual.Totals$year, xlab = "Year",
        ylab = "PM2.5 Emissions (Tons * 10^3)",
        main = "Total PM2.5 Emissions from All Baltimore SourceS (fips = 24510)")

# Save PNG image file
dev.copy(png, filename = "Plot2.png", width = 480, height = 480)
dev.off()