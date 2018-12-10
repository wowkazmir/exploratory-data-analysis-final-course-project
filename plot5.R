library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset data

motorv.baltmary <- NEI[(NEI$fips=="24510") & (NEI$type=="ON-ROAD"),]

emissions.vehicles <- summarise(group_by(motorv.baltmary, year), Emissions= sum(Emissions))

## Saves the plot to a png file

png('plot5.png', width = 640, height = 480)  

g <- ggplot(emissions.vehicles, 
            aes(x = factor(year), y = Emissions, label = round(Emissions,0)))

g + geom_bar(stat="identity", fill = "steelblue") +
    labs(x ="Year",  y = expression("Total PM"[2.5]* " emissions in tons")) +
    guides(fill=FALSE) +
    ggtitle(expression("Total PM"[2.5]* " emissions from motor vehicle sources in Baltimore City from 1999-2008")) + 
    geom_text(fontface = "bold", nudge_y = 9, check_overlap = TRUE)

dev.off()