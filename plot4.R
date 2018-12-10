library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset data

coal.sources <- SCC[grepl("Fuel Comb.*Coal", SCC$EI.Sector), ]

emissions.subset <- NEI[(NEI$SCC %in% coal.sources$SCC), ]

emissions.coalcomb <- summarise(group_by(emissions.subset, year), Emissions= sum(Emissions))

## Saves the plot to a png file

png('plot4.png', width = 640, height = 480)  

g <- ggplot(emissions.coalcomb, 
                aes(x = factor(year), y = Emissions/1000, label = round(Emissions/1000,0)))

g + geom_bar(stat="identity", fill = "steelblue") +
    labs(x ="Year",  y = expression("Total PM"[2.5]* " emissions in kilotons")) +
    guides(fill=FALSE) +
    ggtitle(expression("Total PM"[2.5]* " emissions from coal combustion-related sources in the United States from 1999 to 2008")) + geom_text(fontface = "bold", nudge_y = 15, check_overlap = TRUE)

dev.off()