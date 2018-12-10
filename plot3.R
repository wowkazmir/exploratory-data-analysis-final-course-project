library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset data

emissions.baltmary <- summarise(group_by(filter(NEI, fips=="24510"), year, type), Emissions= sum(Emissions))

## Saves the plot to a png file

png('plot3.png', width = 640, height = 480)  

g <- ggplot(emissions.baltmary, 
            aes(x = factor(year), y = Emissions, fill = type, label = round(Emissions,0)))

g + geom_bar(stat="identity") +
    facet_grid(. ~ type) +
    labs(x ="Year",  y = expression("Total PM"[2.5]* " emissions in tons")) + 
    guides(fill=guide_legend("Type")) +
    ggtitle(expression("Total PM"[2.5]* " emissions in Baltimore City by various source types from 1999 to 2008")) + geom_text(nudge_y = 50 , check_overlap = TRUE)

dev.off()
