library("data.table")

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

nei = readRDS(dest_file_summary)
scc = readRDS(dest_file_source)

nei = data.table(nei)
scc = data.table(scc)
merged = merge(nei, scc, by = "SCC")

rm(scc)

#coal = grepl("coal", merged$Short.Name)
coal = c()
nei = merged[coal, ]
nei_sum = nei[, list(Emissions = sum(Emissions)), by = year]

png(".\\data\\Exploratory_DA\\plot4.png", width = 480, height = 480)
x = barplot(nei_sum$Emissions, nei_sum$year, ylim = c(0, 7e3), col = "blue", border = "red",
            xlab = "Year", ylab = "PM2.5, tons", names.arg = nei_sum$year,
            main = "Total PM2.5 emissions from coal combustion-related sources across the USA.")
text(plot, y = round(nei_sum$Emissions, 2), label = round(nei_sum$Emissions, 2), pos = 3)
dev.off()

print("DONE")
