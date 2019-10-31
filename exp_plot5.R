library("data.table")

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
nei_balt = subset(nei, fips == "24510" & type == "ON-ROAD")

nei_balt_sum = nei_balt[, list(Emissions = sum(Emissions)), by = year]

png(".\\data\\Exploratory_DA\\plot5.png", width = 480, height = 480)
plot = barplot(nei_balt_sum$Emissions, nei_balt_sum$year, ylim = c(0, 400), col = "blue", 
            border = "red", xlab = "Year", ylab = "PM2.5, tons", names.arg = nei_balt_sum$year, 
            main = "Total PM2.5 emissions for motor vehicle sources in Baltimore City.")
text(plot, y = round(nei_balt_sum$Emissions, 2), label = round(nei_balt_sum$Emissions, 2), pos = 3)
dev.off()

print("DONE")
