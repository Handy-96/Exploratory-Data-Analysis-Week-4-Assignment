library("data.table")
setwd("D:/Handy/Coursera/Modul 4/Week 4")
path <- getwd()
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "week4project2.zip", sep = "/"))
unzip(zipfile = "week4project2.zip")

Classification <- data.table::as.data.table(x = readRDS(file = "Source_Classification_Code.rds"))
SumSSC <- data.table::as.data.table(x = readRDS(file = "summarySCC_PM25.rds"))

SumSSC[, Emissions := lapply(.SD, as.numeric), .SDcols = c("Emissions")]
totalSumSSC <- SumSSC[fips=='24510', lapply(.SD, sum, na.rm = TRUE)
                , .SDcols = c("Emissions")
                , by = year]

png(filename='plot2.png')

barplot(totalSumSSC[, Emissions]
        , names = totalSumSSC[, year]
        , xlab = "Years", ylab = "Emissions"
        , main = "Emissions over the Years")

dev.off()