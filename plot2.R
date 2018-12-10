library(dplyr)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")
 
## Subset data

total.baltmary <- summarise(group_by(filter(NEI, fips=="24510"), year), Emissions=sum(Emissions))

## Saves the plot to a png file

png('plot2.png', width = 640, height = 480)

x1 <- with(total.baltmary, {
    barplot(names.arg=factor(year), height=Emissions, col = "steelblue",
    xlab="Years", ylab= expression("Total PM"[2.5]* " emissions in tons"), ylim=c(0,4000),
    main= expression("Total PM"[2.5]* " emissions in Baltimore City, Maryland from 1999 to 2008"))
    })

## Add bar values

text(x = x1, y = round(total.baltmary$Emissions,0), label = round(total.baltmary$Emissions,0), pos = 3, cex = 1, col = "black")

dev.off()