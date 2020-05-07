
library(tidyverse)
library(psych)
library(stats)
library(corrplot)
library(tidyselect)

# downloading data

report2015 <- as.data.frame(read_csv("https://storage.googleapis.com/kaggle-datasets/894/2508/2015.csv?GoogleAccessId=web-data@kaggle-161607.iam.gserviceaccount.com&Expires=1550745039&Signature=jlxFC9jRzLf7VeW7abf2p40DoY4TEj8epGbRGq5mLef0HKpSTarTiiWY3K23lI1ShUea2Jw734FMB0g1ltAYkA5d1TLhFnR%2Fp3uPcfRvBmNRk4N8yWAXpyUM6JoSm6yVn2L1oJIVpk8ZCRUwkQiDOUnlHD2XwUWRLfi5VcXHtkOiZvTyXtqwIFAL%2FsGVQp8Jk60IYZzJPgGrfA8aOVjS%2BxgCeo%2FwnbzFL19wjc4PAJ7HkO3a03uODH6JlfzA6rfJD3KvBmNjM5rvo9v0Lca%2BxoXD6yZn1Da94v39SWoWFUByAZiMocC%2B1k9xT7P5qLLbpMmrn4Ra1wlVdhEnKvKkxw%3D%3D", col_names = TRUE))
report2017 <- as.data.frame(read_csv("https://storage.googleapis.com/kaggle-datasets/894/2508/2017.csv?GoogleAccessId=web-data@kaggle-161607.iam.gserviceaccount.com&Expires=1550745305&Signature=HntxxDTj2c61YuCt7LLxg70RfLUghIf9btv0Yy9POQTPBvID81VVLc8mcViZkp%2BMC1Lq1ONKvutlZ4gt6Zf%2FS3QU2E5MoqNxeQKn6O53dIZwfgnZEeQ%2FD5u90sx7FBG8l7cvaEJPz12gax7yzPblVLhqv7pBWy%2FXq0Go4Fr%2ByPPyWIjh7KCjKQ2MkLZ42ohYfragGN2wol0phPTGQjrB1dd7MqEe9IoPNYHle9p6rLKyeTrQNgibpIMSgYNfNaWrYtg3Z8KxWR58%2B305k1y1bQGsjTw7ZLkXZE3Zs85SJonec%2FINLgUI%2BiN5ZDHQuOtg%2Bxr3cQdb04GsyWR2MxEbqQ%3D%3D", col_names = TRUE))
report2015 <- report2015[c('Country', 'Region')]
report2017 <- left_join(report2017, report2015)

# checking for NAs

row.has.na <- is.na(report2017['Region']) 
sum(row.has.na)
NAs <- which(is.na(report2017['Region']))
report2017[NAs, c("Country", "Region")]

# inserting missing values 

report2017[93, "Region"] <- "Sub-Saharan Africa" 
report2017[33, "Region"] <- "Eastern Asia"
report2017[50, "Region"] <- "Latin America and Caribbean"
report2017[71, "Region"] <- "Eastern Asia"
report2017[111, "Region"] <- "Sub-Saharan Africa"
report2017[147, "Region"] <- "Sub-Saharan Africa"

unique(report2017$Region)

report <- dplyr::select(report2017, Country, Region, everything()) 
head(report)
names(report)

report <- report[, -c(5,6,13)]

colnames(report) <- c("Country", "Region", "Happiness.Rank", "Happiness.Score",
                          "GDPpc", "Family",
                          "Life.Expectancy", "Freedom", "Generosity", "Trust")

plot.data <- cor(report[, 4:10])
corrplot(plot.data, main = "Correlation matrix", tl.cex = 0.8, number.cex = 0.8, diag = TRUE, tl.col = "black", method = "color", addCoef.col="grey", order = "AOE")

report$Continent <- NA

report$Continent[which(report$Country %in% c("Israel", "United Arab Emirates", "Singapore", "Thailand", "Taiwan Province of China",
                                                   "Qatar", "Saudi Arabia", "Kuwait", "Bahrain", "Malaysia", "Uzbekistan", "Japan",
                                                   "South Korea", "Turkmenistan", "Kazakhstan", "Turkey", "Hong Kong S.A.R., China", "Philippines",
                                                   "Jordan", "China", "Pakistan", "Indonesia", "Azerbaijan", "Lebanon", "Vietnam",
                                                   "Tajikistan", "Bhutan", "Kyrgyzstan", "Nepal", "Mongolia", "Palestinian Territories",
                                                   "Iran", "Bangladesh", "Myanmar", "Iraq", "Sri Lanka", "Armenia", "India", "Georgia",
                                                   "Cambodia", "Afghanistan", "Yemen", "Syria"))] <- "Asia"
report$Continent[which(report$Country %in% c("Norway", "Denmark", "Iceland", "Switzerland", "Finland",
                                                   "Netherlands", "Sweden", "Austria", "Ireland", "Germany",
                                                   "Belgium", "Luxembourg", "United Kingdom", "Czech Republic",
                                                   "Malta", "France", "Spain", "Slovakia", "Poland", "Italy",
                                                   "Russia", "Lithuania", "Latvia", "Moldova", "Romania",
                                                   "Slovenia", "North Cyprus", "Cyprus", "Estonia", "Belarus",
                                                   "Serbia", "Hungary", "Croatia", "Kosovo", "Montenegro",
                                                   "Greece", "Portugal", "Bosnia and Herzegovina", "Macedonia",
                                                   "Bulgaria", "Albania", "Ukraine"))] <- "Europe"
report$Continent[which(report$Country %in% c("Canada", "Costa Rica", "United States", "Mexico",  
                                                   "Panama","Trinidad and Tobago", "El Salvador", "Belize", "Guatemala",
                                                   "Jamaica", "Nicaragua", "Dominican Republic", "Honduras",
                                                   "Haiti"))] <- "North America"
report$Continent[which(report$Country %in% c("Chile", "Brazil", "Argentina", "Uruguay",
                                                   "Colombia", "Ecuador", "Bolivia", "Peru",
                                                   "Paraguay", "Venezuela"))] <- "South America"
report$Continent[which(report$Country %in% c("New Zealand", "Australia"))] <- "Australia"
report$Continent[which(is.na(report$Continent))] <- "Africa"

# Moving the continent column's position in the dataset to the second column

report <- report %>% dplyr::select(Country, Continent, everything())
head(report)

# Changing Continent column to factor

report$Continent <- as.factor(report$Continent)
report$Region <- as.factor(report$Region)
report1 <- report

write.table(report, "happiness_report.csv", sep = ",", row.names = FALSE)

report <- read.csv("happiness_report.csv")
attach(report)

# creating boxplots
report$Happiness.Score
ggplot(report, aes(x = Continent, y = Happiness.Score)) +
  geom_boxplot(aes(fill=Continent)) + theme_bw() +
  theme(axis.title = element_text(family = "Helvetica", size = (8)))

ggplot(report, aes(x = report$Happiness.Score, fill = Region)) + geom_histogram(binwidth = 0.15) + labs(x = "Happiness Score")

ggplot(data = report) + geom_point(aes(x = GDPpc, y = Happiness.Score, color = Continent)) + labs(x = "GDP per capita", y = "Happiness Score")
ggplot(data = report) + geom_point(aes(x = GDPpc, y = Happiness.Score, color = Region)) + 
  labs(x = "GDP per capita", y = "Happiness Score") + facet_wrap( ~ Continent, nrow = 2)

report %>%
  arrange(desc(Happiness.Score))
  
ggplot(report[1:12,], aes(x = Country, y = Happiness.Score, fill = Region)) + geom_bar(stat = "identity") + coord_flip()

head(report)
report[c("Happiness.Rank", "Country")]
summary(Happiness.Score)


