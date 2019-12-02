library("data.table")
library("ggplot2")

setwd("D:/Handy/Coursera/Modul 4/Week 4")
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "week4project2.zip", sep = "/"))
unzip(zipfile = "week4project2.zip")

SumSSC <- data.table::as.data.table(x = readRDS("summarySCC_PM25.rds"))
SCC <- data.table::as.data.table(x = readRDS("Source_Classification_Code.rds"))

vehiclesSCC <- SCC[grepl("vehicle", SCC[, SCC.Level.Two], ignore.case=TRUE)
                   , SCC]
vehiclesSumSSC <- SumSSC[SumSSC[, SCC] %in% vehiclesSCC,]


baltimoreVehiclesSumSSC <- vehiclesSumSSC[fips=="24510",]

png("plot5.png")

ggplot(baltimoreVehiclesSumSSC,aes(factor(year),Emissions)) +
  geom_bar(stat="identity", fill ="#FF9999" ,width=0.75) +
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (10^5 Tons)")) + 
  labs(title=expression("PM"[2.5]*" Motor Vehicle Source Emissions in Baltimore from 1999-2008"))

dev.off()