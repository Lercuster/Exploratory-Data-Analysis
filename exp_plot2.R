


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
#scc <- readRDS(dest_file_source)
nei = data.table(nei)

nei_balt = subset(nei, nei$fips == "24510")
nei_balt_sub <- nei_balt[, list(emissions=sum(Emissions)), by=year]

png(".\\data\\Exploratory_DA\\plot2.png", width = 480, height = 480)
plot = barplot(nei_balt_sub$emissions, col = "blue", border = "red",
               main = "Total amount of PM2.5 in Baltimore, Maryland", xlab = "Year", ylab = "PM2.5, tons",
               names.arg = nei_balt_sub$year, ylim = c(0, 4e3) )
text(plot, y = round(nei_balt_sub$emissions, 2), label = round(nei_balt_sub$emissions, 2), pos = 3)
dev.off()

print("DONE")