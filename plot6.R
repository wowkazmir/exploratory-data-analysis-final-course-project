library(dplyr)
library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset data

city.emissions <- summarise(group_by(filter(NEI, fips %in% c("06037", "24510") & type == "ON-ROAD"), fips, year), Emissions=sum(Emissions))

city.emissions  <- mutate(city.emissions, county = ifelse(fips == "06037",  "Baltimore City, MD", "Los Angeles County, CA"))

## Saves the plot to a png file

png('plot6.png', width = 840, height = 480)  

g <- ggplot(city.emissions,  
            aes(x = factor(year), y = Emissions, fill=county, label = round(Emissions,0)))

g + facet_grid(county~., scales="free_y") +
    geom_bar(stat="identity") +
    labs(x ="Year",  y = (expression("Total PM"[2.5]* " emissions in tons"))) +
    guides(fill=guide_legend("County"), col = FALSE) +
    ggtitle(expression("Total PM"[2.5]* " emissions from motor vehicle sources in Baltimore City and Los Angeles County from 1999-2008")) +
    geom_label(col="black", fontface = "bold")

dev.off()