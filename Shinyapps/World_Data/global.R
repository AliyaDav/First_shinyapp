all_data = read_csv("all_data.csv")
all_data[,2:12] = type_convert(all_data[,2:12])
all_data = all_data %>% mutate(
  status = case_when(
    income <= 1000 ~ "low",
    income <= 4000 & income > 1000 ~ "lower_middle",
    income <= 12000 & income > 4000 ~ "upper_middle",
    income > 12000 ~ "high",
    TRUE ~ as.character(income)
  )
)
all_data$status = factor(all_data$status, 
                         levels = c("high","upper_middle","lower_middle","low"), 
                         labels = c("high","upper_middle","lower_middle","low"))

latin = c("Belize", "Costa Rica", "El Salvador", "Guatemala", 
                    "Honduras", "Mexico", "Nicaragua", "Panama", "Argentina", 
                    "Bolivia", "Brazil", "Honduras", "Panama", "Trinidad and Tobago", 
                    "Jamaica","Bahamas",
                    "Chile", "Colombia", "Ecuador", "French Guiana", "Guyana",
                    "Paraguay", "Peru", "Suriname", "Uruguay", "Venezuela", 
                    "Cuba", "Dominican Republic", "Haiti")
latin = filter(all_data, country %in% latin)
west_asia = c("Afghanistan", "Armenia", "Azerbaijan", "Bahrain", 
              "Cyprus", "Georgia", "Iran", "Iraq", "Israel", "Jordan", 
              "Kuwait", "Lebanon", "Oman", "Qatar", "Saudi Arabia", "Syria", 
              "Turkey", "United Arab Emirates", "West Bank and Gaza", "Yemen")
west_asia = filter(all_data, country %in% west_asia)
#africa = unique(as.character(gapminder$country[gapminder$continent == "Africa"]))
africa = filter(all_data, country %in% gapminder$country[gapminder$continent == "Africa"])

#all_regions = list("latin"=latin, "west_asia" = west_asia, "africa"=africa)

avg_income = all_data %>% 
  filter(year %in% 1960:2011 & !is.na(status) & !is.na(income)) %>%
  dplyr::group_by(year, status) %>% 
  dplyr::mutate(avg_inc = mean(income)) 

avg_aid = all_data %>% 
  filter(year %in% 1975:2010 & !is.na(status) & !is.na(aid)) %>%
  dplyr::group_by(year, status) %>% 
  dplyr::mutate(avg_aid = mean(aid))

#LA_data_chart = latin
#LA_data_chart$country <- as.factor(LA_data_chart$country)  # for right ordering of the dumbells
# attach(LA_data_chart)

theme_set(theme_classic(base_size = 16))

df_for_gg = function(region_df) {
  region_df$country <- as.factor(region_df$country)  # for right ordering of the dumbells
  region_df %>% 
    select(country, year, income) %>% 
    drop_na(income) %>% 
    spread(key = year, value = income) %>%
    mutate(differ = round((`2011` - `1995`)*100/`1995`,2))
}

gg = function(df) {
  ggplot(df, aes(x = df$`1995`, 
                    xend = df$`2011`, y=country, group=country)) + 
    ggalt::geom_dumbbell(color="#23888EFF", 
                         size=0.75, 
                         point.colour.l="#31688EFF") + 
    geom_text(aes(x = (max(df$`2011`, na.rm = T)), label = paste0(df$differ, "%")),
              color = ifelse(df$differ< 0, "red", "black"), hjust = -0.5, size=4) +
    labs(x=NULL, y=NULL, title="Income per cap: 1995 vs 2011") +
    theme(plot.title = element_text(size = 16, hjust=0.5, face="bold"),
          plot.background=element_rect(fill="white"),
          panel.background=element_rect(fill="white"),
          panel.grid.minor=element_blank(),
          panel.grid.major.y=element_blank(),
          panel.grid.major.x=element_line(size = 0.5, color = "grey"),
          axis.ticks=element_blank(),
          legend.position="top",
          panel.border=element_blank()) +
    xlim(min(df$`1995`, na.rm = T), max(df[!is.na(df$`1995`),]$`2011`, na.rm = T)+3000)
}

income_col = function(df) {
  df %>% 
    dplyr::filter(year >= 1960) %>% 
    dplyr::select(year, status) %>% 
    drop_na() %>%
    dplyr::group_by(year) %>% plyr::count() %>% 
    ggplot(aes(x = year, y = freq, fill = status)) +
    geom_col(position = "fill") +
    scale_fill_viridis_d() +
    theme(axis.text.x = element_text(angle = 45, hjust = 1), 
          plot.title = element_text(lineheight = 1, hjust = 0.5, size = 18, face="bold")) +
    labs(title = "Changes within income groups in 1960-2011", 
         y = "Proportion")+ xlab(NULL)
}

df_for_barchart = function(region) {
  data_dev = region %>%
    filter(year == "2009") %>% 
    drop_na(income) %>%
    mutate(income_z = round((income - mean(income))/sd(income), 2),
           type = ifelse(income_z < 0, "below", "above")) 
  data_dev = data_dev[order(data_dev$income_z),]  
  data_dev = data_dev %>%
    mutate(country = factor(country, levels = unique(country)))
  data_dev
}

#LA_data_dev <- LA_data_dev[order(LA_data_dev$income_z), ]  # sort
#LA_data_dev$country <- factor(LA_data_dev$country, levels = LA_data_dev$country)  # convert to factor to retain sorted order in plot.

# Diverging Barcharts
divchart = function(df) {
  ggplot(df, aes(x=country, y=income_z)) +
  geom_bar(stat='identity', aes(fill=df$type), width=.5)  +
  scale_fill_manual(name="Income",
                    labels = c("Above average", "Below average"),
                    values = c("above"="#B4DE2CFF", "below"="#440154FF")) +
  labs(subtitle="Year 2009",
       title= "Income differences", y ="Normalized income")+
    theme(plot.title = element_text(lineheight = 1, face="bold")) +
  coord_flip()
}

aid_by_groups = function(df) {
  df %>% 
    filter(year %in% c(1975:2010)) %>%
    drop_na(aid, status) %>%
    group_by(year, status) %>% 
    dplyr:: mutate(avg_aid = mean(aid)) %>% 
    ggplot(aes(x = year, y = avg_aid, group = status)) +
    geom_line(aes(color = status), lwd = 1, alpha = 0.8) + 
    scale_colour_viridis_d() +
    labs(title = "Aid received by different status groups in 1975-2010",
         y = "Average aid per capita") + xlab(NULL) + 
    theme(plot.title = element_text(lineheight = 1, hjust = 0.5, face="bold"))
}
aid_col_sum = function(df) {
  df %>% 
    filter(year %in% c(1975:2010)) %>%
    drop_na(aid, status) %>%
    group_by(country) %>%
    dplyr:: mutate(sum_aid = sum(aid)) %>%
    select(country, sum_aid) %>%
    distinct() %>%
    arrange(desc(sum_aid)) %>%
    ggplot(aes(country, sum_aid, group = country)) + 
    geom_col(aes(fill = country)) + 
    scale_fill_viridis_d() +
    coord_flip()+
    labs(title = "Total aid received in 1975-2010") + ylab("Cumulative aid") +
    xlab(NULL) + 
    theme(plot.title = element_text(lineheight = 1, hjust = 0.5, face="bold"), 
          legend.position = "none")
}

most_aid_table = function(df) {
  most_aid = df %>% 
    filter(year %in% c(1975:2010)) %>%
    drop_na(aid, status) %>%
    group_by(country) %>%
    dplyr:: mutate(sum_aid = sum(aid)) %>%
    select(country, sum_aid) %>%
    distinct() %>%
    arrange(desc(sum_aid))
  (most_aid = most_aid[1:6,])
}
top6_aid = function(df) {
  df %>% 
    filter(country %in% most_aid_table(df)$country & year %in% c(1975:2010)) %>%
    ggplot(aes(x = year)) +
    geom_line(aes(y = aid, color = "Aid received"), color = "#B4DE2CFF", lwd = 1) +
    geom_line(aes(y = income, color = "Income per cap"), color = "#440154FF", lwd = 1) +
    facet_wrap(~country) +
    theme(axis.text.x = element_text(angle = 45, hjust = 1), 
          plot.title = element_text(lineheight = 1, hjust = 0.5, face = "bold"), 
          legend.position = "right") +
    labs(title = "Aid and income in 1975-2010", 
         y = "Aid per capita") + xlab(NULL)
}
top6_health = function(df) {
  df %>% 
    filter(country %in% most_aid_table(df)$country & year %in% c(1995:2010)) %>%
    ggplot(aes(x = year, y = health_spend)) +
    geom_line(aes(color = country), lwd = 1, alpha = 0.8) + 
    scale_colour_viridis_d() +
    facet_wrap(~country) + 
    theme(axis.text.x = element_text(angle = 45, hjust = 1), 
          plot.title = element_text(lineheight = 1, hjust = 0.5, face = "bold"), 
          plot.subtitle = element_text(hjust = 0.5),
          legend.position = "none") +
    labs(title = "Total health spending (% of GDP)", 
         subtitle = "Years 1995-2010") + xlab(NULL) + ylab(NULL)
}
top6_sanit = function(df) {
  df %>% 
    filter(country %in% most_aid_table(df)$country & year %in% c(1990:2010)) %>%
    ggplot(aes(x = year, y = sanit_access)) +
    geom_line(aes(color = country), lwd = 1, alpha = 0.8) + 
    scale_colour_viridis_d() +
    facet_wrap(~country) + 
    theme(axis.text.x = element_text(angle = 45, hjust = 1), 
          plot.title = element_text(lineheight = 1, hjust = 0.5, face ="bold"), 
          plot.subtitle = element_text(hjust = 0.5),
          legend.position = "none") +
    labs(title = "Proportion of the population using improved \n sanitation facilities, total", 
         subtitle = "Years 1970-2011") + xlab(NULL)+ ylab(NULL)
}
top6_child = function(df) {
  df %>% 
    filter(country %in% most_aid_table(df)$country & year %in% c(1980:2015)) %>%
    ggplot(aes(x = year, y = child_mortality)) +
    geom_line(aes(color = country), lwd = 1, alpha = 0.8) + 
    scale_colour_viridis_d() +
    facet_wrap(~country) + 
    theme(axis.text.x = element_text(angle = 45, hjust = 1), 
          plot.title = element_text(lineheight = 1, hjust = 0.5,  face ="bold"),
          plot.subtitle = element_text(hjust = 0.5),
          legend.position = "none") +
    labs(title = "Child mortality rate",
         subtitle =  "Years 1980-2015") + xlab(NULL)+ ylab(NULL)
}
top6_life = function(df) {
  df %>% 
    filter(country %in% most_aid_table(df)$country & year %in% c(1970:2011)) %>%
    ggplot(aes(x = year, y = life_exp)) +
    geom_line(aes(color = country), lwd = 1, alpha = 0.8) + 
    scale_colour_viridis_d() +
    facet_wrap(~country) + 
    theme(axis.text.x = element_text(angle = 45, hjust = 1), 
          plot.title = element_text(lineheight = 1, hjust = 0.5,  face ="bold"),
          plot.subtitle = element_text(hjust = 0.5),
          legend.position = "none") +
    labs(title = "Life expentancy",
         subtitle =  "Years 1980-2015") + xlab(NULL)+ ylab(NULL)
}
