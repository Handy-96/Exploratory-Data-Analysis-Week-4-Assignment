library("data.table")

setwd("D:/Handy/Coursera/Modul 4/Week 4")
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "week4project2.zip", sep = "/"))
unzip(zipfile = "week4project2.zip")

SSC <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
SumSSC <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

condition <- grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
vehiclesSCC <- SCC[condition, SCC]
vehiclesSumSSC <- SumSSC[SumSSC[, SCC] %in% vehiclesSCC,]

vehiclesBaltimoreSumSSC <- vehiclesSumSSC[fips == "24510",]
vehiclesBaltimoreSumSSC[, city := c("Baltimore City")]

vehiclesLASumSSC <- vehiclesSumSSC[fips == "06037",]
vehiclesLASumSSC[, city := c("Los Angeles")]

bothSumSSC <- rbind(vehiclesBaltimoreSumSSC,vehiclesLASumSSC)

png("plot6.png")

ggplot(bothSumSSC, aes(x=factor(year), y=Emissions, fill=city)) +
  geom_bar(aes(fill=year),stat="identity") +
  facet_grid(scales="free", space="free", .~city) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Kilo-Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore & LA, 1999-2008"))

dev.off()