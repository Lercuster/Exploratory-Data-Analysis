
library(ggplot2)

file_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
dest_file = ""
if(!file.exists(".\\data\\Exploratory_DA.zip")){
  download.file(file_url, ".\\data\\Exploratory_DA.zip")
} else {
  print("no need to download")
}

if(!file.exists(".\\data\\Exploratory_DA")){
  unzip(".\\data\\Exploratory_DA.zip", exdir = ".\\data\\\\Exploratory_DA")
} else {
  print("no need to unzip")
}

dest_file_summary = ".\\data\\Exploratory_DA\\summarySCC_PM25.rds"
dest_file_source = ".\\data\\Exploratory_DA\\Source_Classification_Code.rds"

nei <- readRDS(dest_file_summary)
scc <- readRDS(dest_file_source)
nei = data.table(nei)

nei_balt = subset(nei, nei$fips == "24510")
nei_balt_mean = nei_balt[, list(Emissions = mean(Emissions)), by= c("year", "type")]

png(".\\data\\Exploratory_DA\\plot3.png", width = 480, height = 480)
print(qplot(nei_balt_mean$year, nei_balt_mean$Emissions, data = nei_balt_mean, 
            facets = .~type, geom = c("point", "path"), 
            main = "Mean value of PN2.5 emissions for each source", 
            xlab = "Year", ylab = "Mean value of PM2.5, tons"))
dev.off()

print("DONE")