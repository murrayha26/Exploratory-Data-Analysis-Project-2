# Check if the file exists, if not, download it
if (!file.exists("exdata_data_NEI_data.zip")) {
  download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip",
                "exdata_data_NEI_data.zip", method = "curl")
}

# Unzip the data file
unzip("exdata_data_NEI_data.zip")

# Load NEI and SCC data
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Sum total emission by year
annual.Totals <- aggregate(Emissions ~ year, NEI, sum)

barplot(annual.Totals$Emissions/10^6, names.arg = annual.Totals$year, xlab = "Year", ylab = "PM2.5 Emissions (million Tons)",
        main = "Total PM2.5 Emissions from All US Sources")

# Save PNG image file
dev.copy(png, filename = "Plot1.png", width = 480, height = 480)
dev.off()