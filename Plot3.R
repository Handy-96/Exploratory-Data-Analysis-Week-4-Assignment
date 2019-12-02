library("data.table")
library("ggplot2")

setwd("D:/Handy/Coursera/Modul 4/Week 4")
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "week4project2.zip", sep = "/"))
unzip(zipfile = "week4project2.zip")

Classification <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
SumSSC <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))


baltimoreSumSSC <- SumSSC[fips=="24510",]

png("plot3.png")

ggplot(baltimoreSumSSC,aes(factor(year),Emissions,fill=type)) +
  geom_bar(stat="identity") +
  theme_bw() + guides(fill=FALSE)+
  facet_grid(.~type,scales = "free",space="free") + 
  labs(x="year", y=expression("Total PM"[2.5]*" Emission (Tons)")) + 
  labs(title=expression("PM"[2.5]*" Emissions, Baltimore City 1999-2008 by Source Type"))

dev.off()