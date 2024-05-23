library(ggplot2)

# Load NEI and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Pull the subset of data pertaining to Baltimore (fip = 24510)
BaltimoreNEI <- NEI[NEI$fips=="24510",]

# Sum total Baltimore emission by year
Baltimore.Annual.Totals <- aggregate(Emissions ~ year, BaltimoreNEI, sum)

# Plot Emissions by type (Use faceting to see individual trends)
ggplot(BaltimoreNEI, aes(factor(year), Emissions, fill = type)) +
  geom_bar(stat = "identity") +
  facet_grid(~type) +
  labs(x="Year", y="Total 2.5PM Emissions (Tons)", title = "Baltimore City Total Emissions by Source Type 1999-2008")

# Save PNG image file
dev.copy(png, filename = "Plot3.png", width = 480, height = 480)
dev.off()
