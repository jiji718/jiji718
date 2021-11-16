
library(DataExplorer)
library(readr)
library(jsonlite)
library(stringr)

# Reading File
mc_file <- "depot/tdm-ff/data/modcloth_final_data.json"
mc <- fromJSON(sprintf("[%s]", paste(readLines(mc_file), collapse=",")))

print(head(mc))
print(colnames(mc))
print(summary(mc))

# Selecting Columns
mc_data <- mc[, c("item_id","waist","size","quality","cup size","hips","bra size","category",      
                  "bust","height","length", "fit","shoe size","shoe width" )]

print(head(mc_data))
# Refining Data

### Character -> Factor

mc_data$item_id <- as.numeric(mc_data$item_id)
mc_data$waist <- as.numeric(mc_data$waist)
mc_data$size <- as.numeric(mc_data$size)
mc_data$quality <- as.numeric(mc_data$quality)
mc_data$`cup size` <- factor(mc_data$`cup size`)
mc_data$hips <- as.numeric(mc_data$hips)
mc_data$`bra size` <- as.numeric(mc_data$`bra size`)
mc_data$category <- factor(mc_data$category)
mc_data$bust <- as.numeric(mc_data$bust)
mc_data$height <- str_remove(mc_data$height, "ft ")
mc_data$height <- str_remove(mc_data$height, "in")
mc_data$height <- as.numeric(mc_data$height)
mc_data$length <- factor(mc_data$length)
mc_data$fit <- factor(mc_data$fit)
mc_data$`shoe size` <- as.numeric(mc_data$`shoe size`)
mc_data$`shoe width` <- as.numeric(mc_data$`shoe width`)

str(mc_data)

# Creating Report
create_report(mc_data)



str(mc_data)
summary(mc_data)
sum(is.na(mc_data$`shoe width`))

###

# Deleting Missing Values
mc_data_rmna <- na.omit(mc_data)
create_report(mc_data_rmna)
