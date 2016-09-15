## Tidy data concept

counts_df <- data.frame(
  day = c("Monday", "Tuesday", "Wednesday"),
  wolf = c(2, 1, 3),
  hare = c(20,25,30),
  fox = c(4,4,4)
)

## Reshaping multiple columns in category/value pairs

library(tidyr)
counts_gather <- gather(counts_df, 
                        key = "species",
                        value = "count",
                        wolf:fox)



## Exercise 1

counts_gather <- counts_gather[-8, ]

counts_spread <- spread(counts_gather,
                        key = species,
                        value = count,
                        fill = 0)

## Read comma-separated-value (CSV) files

surveys <- read.csv("data/surveys.csv")

## removes ""  from the factor levels
surveys <- read.csv("data/surveys.csv", na.strings = "")

## Subsetting and sorting

library(dplyr)
surveys_1990_winter <- filter(surveys, 
                              year == 1990,
                              month %in% 1:3)

surveys_1990_winter <- select(surveys_1990_winter, record_id,
                              month, day, plot_id, species_id,
                              sex, hindfoot_length, weight)

## alternatively use a - to remove column
surveys_1990_winter <- select(surveys_1990_winter, -year)

sorted <- arrange(surveys_1990_winter, 
                  desc(species_id),weight)
head(sorted)

## Exercise 2

surveys_RO <- filter(surveys, species_id == "RO")
surveys_RO <- select(surveys_RO, record_id, sex, weight)

surveys_RO <- select(filter(surveys,species_id=="RO"),record_id, sex, weight)


## Grouping and aggregation

surveys_1990_winter_gb <- group_by(surveys_1990_winter, species_id)
counts_1990_winter <- summarize(surveys_1990_winter_gb, count = n())


## Exercise 3

surveys_DM <- filter(surveys, species_id=="DM")
surveys_DM <- select(surveys_DM, month, weight, hindfoot_length)
surveys_DM_gb <-group_by(surveys_DM, month)
surveys_DM_avg <-summarize(surveys_DM_gb, hfl_avg = mean(hindfoot_length, na.rm=T), 
                                          wgt_avg=mean(weight, na.rm=T))


## Pivto tables through aggregate and spread

surveys_1990_winter_gb <- group_by(surveys_1990_winter, ...)
counts_by_month <- ...(surveys_1990_winter_gb, ...)
pivot <- ...

## Transformation of variables

prop_1990_winter <- mutate(...)

## Exercise 4

...

## Chainning with pipes

c(1, 3, 5) %>% sum()

c(1, 3, 5, NA) %>% sum(na.rm = TRUE)

## Do the same as exercises 3-4 using piping

prop_1990_winter_piped <- surveys %>%
  filter(year == 1990, month %in% 1:3) %>%
  select(-year) %>% # select all columns but year
  group_by(species_id) %>% # group by species_id
  summarize(counts = n()) # summarize with counts
  ... # mutate into proportions
