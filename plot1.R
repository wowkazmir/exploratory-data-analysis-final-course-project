library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
  
## Subset data

total.emissions <- summarise(group_by(NEI, year), Emissions=sum(Emissions))

## Saves the plot to a png file

png('plot1.png', width = 640, height = 480)  

x1 <- with(total.emissions, {
    barplot(names.arg=factor(year), height=Emissions/1000, col = "steelblue", 
    xlab="Years", ylab=expression("Total PM"[2.5]* " emissions in kilotons"), ylim=c(0,8000),
    main=expression("Total PM"[2.5]* " emissions in the United States from 1999 to 2008")
    )})

## Add bar values

text(x = x1, y = round(total.emissions$Emissions/1000,0), label = round(total.emissions$Emissions/1000,0), pos = 3, cex = 1, col = "black")

dev.off()


