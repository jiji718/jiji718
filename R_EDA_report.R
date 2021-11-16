
library(DataExplorer)
library(readr)
library(jsonlite)
library(stringr)

# Reading File
rtr_file <- "depot/tdm-ff/data/renttherunway_final_data.json"
rtr <- fromJSON(sprintf("[%s]", paste(readLines(rtr_file), collapse=",")))

print(head(rtr))
print(colnames(rtr))
print(summary(rtr))

# Selecting Columns
rtr_data <- rtr[, c("fit","bust size","item_id","weight","body type","category","height","size","age")]

print(head(rtr_data))
# Refining Data

### Character -> Factor

print(rtr_data$fit)

rtr_data$fit <- factor(rtr_data$fit, levels = c("small","fit","large"))
rtr_data$`bust size_num` <- str_sub(rtr_data$`bust size`, 1, 2)
rtr_data$`bust size_alp` <- str_sub(rtr_data$`bust size`, 3,3)
rtr_data$`bust size_num` <- as.numeric(rtr_data$`bust size_num`)

rtr_data$`bust size_alp` <- as.character(rtr_data$`bust size_alp`)
rtr_data$`bust size_alp` <- as.factor(rtr_data$`bust size_alp`)

rtr_data$item_id <- as.numeric(rtr_data$item_id)
rtr_data$weight <- str_remove(rtr_data$weight, "lbs")
rtr_data$weight <- as.numeric(rtr_data$weight)

rtr_data <- rtr_data[,-2]
rtr_data$`body type` <- as.factor(rtr_data$`body type`)
rtr_data$category <- as.factor(rtr_data$category)

str(rtr_data)
rtr_data$height <- str_remove(rtr_data$height, "' ") 
rtr_data$height <- str_remove(rtr_data$height, "\"") 
rtr_data$height <- as.numeric(rtr_data$height)
rtr_data$age <- as.numeric(rtr_data$age)
  
str(rtr_data)

# Creating Report
create_report(rtr_data)



str(rtr_data)
summary(rtr_data)


###

# Deleting Missing Values
rtr_data_rmna <- na.omit(rtr_data)
create_report(rtr_data_rmna)
