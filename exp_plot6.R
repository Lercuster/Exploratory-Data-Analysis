library("data.table")
library("ggplot2")

file_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

if(!file.exists(".//data//Exploratory_DA//Course_Project2.zip")){
  download.file(file_url, ".\\data\\Exploratory_DA\\Course_Project2.zip")
} else {
  print("no need to download")
}

if(!file.exists(".\\data\\Exploratory_DA\\Source_Classification_Code.rds")){
  unzip(".\\data\\Exploratory_DA\\Course_Project2.zip", 
        exdir = ".\\data\\Exploratory_DA")
} else {
  print("no need to unzip")
}

dest_file_summary = ".\\data\\Exploratory_DA\\summarySCC_PM25.rds"
dest_file_source = ".\\data\\Exploratory_DA\\Source_Classification_Code.rds"

nei = readRDS(dest_file_summary)
scc = readRDS(dest_file_source)

nei = data.table(nei)
scc = data.table(scc)
nei_sub = subset(nei, fips %in% c("24510", "06037") & type == "ON-ROAD")

nei_sum = nei_sub[, list(Emissions = sum(Emissions)), by = c("year", "fips")]

png(".\\data\\Exploratory_DA\\plot6.png", width = 480, height = 480)
x = ggplot(nei_sum, aes(x = year, y = Emissions, col = fips)) +
                        ggtitle("Comparison PM2.5 emissions from motor vehicles in Baltimore and LA.") +  
                        xlab("Year") + ylab("Mean value of PM2.5, tons")
x = x + geom_line() + geom_point() + scale_colour_discrete(name="City", 
                                        breaks = c("06037", "24510"),labels = c("LA", "Baltimore"))
print(x)
dev.off()

print(x)
print("DONE")
