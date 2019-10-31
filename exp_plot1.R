library(data.table)

file_url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"

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
nei_sub <- nei[, list(emissions=sum(Emissions)), by=year]

png(".\\data\\Exploratory_DA\\plot1.png", width = 480, height = 480)
plot = barplot(nei_sub$emissions, col = "blue", border = "red",
        main = "Total amount of PM2.5 across the USA", xlab = "Year", ylab = "PM2.5, tons",
        names.arg = nei_sub$year,ylim = c(0, 8e6) )
text(plot, y = round(nei_sub$emissions, 2), label = round(nei_sub$emissions, 2), pos = 3)
dev.off()

print("DONE")