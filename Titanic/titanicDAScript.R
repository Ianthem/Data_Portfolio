install.packages("dplyr")
library(dplyr)
titanic_data <- read.csv("Titanic-Dataset.csv")
View(titanic_data)
summary(titanic_data)
str(titanic_data)
titanic_data <- titanic_data %>% mutate(Age = ifelse(is.na(Age), median(Age, na.rm = TRUE), Age)) 
titanic_data <- titanic_data %>% filter(!is.na(Embarked))
titanic_data <- titanic_data %>% select(-Cabin)
titanic_data <- titanic_data %>% mutate(Survived = as.factor(Survived), Pclass = as.factor(Pclass), Sex = as.factor(Sex), Embarked = as.factor(Embarked)) 
names(titanic_data)
names(titanic_data) <- tolower(names(titanic_data))
names(titanic_data)
write.csv(titanic_data, "cleaned_titanic_data.csv", row.names = FALSE) 
library(tidyverse)
install.packages("tidyverse")
library(tidyverse)
ggplot(titanic_data, aes(x = as.factor(survived))) +
  geom_bar() +
  xlab("Survived") +
  ylab("Count") +
  ggtitle("Count of Survived Passengers")

# Histogram of Age
ggplot(titanic_data, aes(x = age)) +
  geom_histogram(binwidth = 5, fill = "blue", color = "black") +
  xlab("Age") +
  ylab("Count") +
  ggtitle("Age Distribution of Passengers")

# Boxplot of Age by Survived
ggplot(titanic_data, aes(x = as.factor(survived), y = age)) +
  geom_boxplot() +
  xlab("Survived") +
  ylab("Age") +
  ggtitle("Age Distribution by Survival Status")

# Violin Plot of Age by Survived
ggplot(titanic_data, aes(x = as.factor(survived), y = age)) +
  geom_violin() +
  xlab("Survived") +
  ylab("Age") +
  ggtitle("Age Distribution and Density by Survival Status")

# Bar Plot of Passenger Class
ggplot(titanic_data, aes(x = as.factor(pclass))) +
  geom_bar(fill = "green") +
  xlab("Passenger Class") +
  ylab("Count") +
  ggtitle("Count of Passengers by Class")

# Bar Plot of Embarked
ggplot(titanic_data, aes(x = embarked)) +
  geom_bar(fill = "purple") +
  xlab("Embarkation Point") +
  ylab("Count") +
  ggtitle("Count of Passengers by Embarkation Point")

# Scatter Plot of Age vs Fare
ggplot(titanic_data, aes(x = age, y = fare)) +
  geom_point(color = "red") +
  xlab("Age") +
  ylab("Fare") +
  ggtitle("Scatter Plot of Age vs. Fare")

# Facet Grid of Age vs. Fare by Survived
ggplot(titanic_data, aes(x = age, y = fare)) +
  geom_point() +
  facet_grid(. ~ survived) +
  xlab("Age") +
  ylab("Fare") +
  ggtitle("Age vs. Fare by Survival Status")

# Facet Grid of Age vs. Fare by pclass
ggplot(titanic_data, aes(x = age, y = fare)) +
  geom_point(color = "brown") +
  facet_grid(. ~ pclass) +
  xlab("Age") +
  ylab("Fare") +
  ggtitle("Age vs. Fare by Passenger Class")

# Stacked Bar Plot of Survival by Passenger Class
ggplot(titanic_data, aes(x = pclass, fill = as.factor(survived))) +
  geom_bar(position = "fill") +
  xlab("Passenger Class") +
  ylab("Proportion") +
  labs(fill = "Survived") +
  ggtitle("Survival Proportions by Passenger Class")

# Calculate counts and percentages for interactive plot
titanic_summary <- titanic_data %>%
  group_by(pclass, survived) %>%
  summarise(count = n()) %>%
  mutate(percentage = count / sum(count) * 100, 
         survival_status = ifelse(survived == 1, "Survived", "Did Not Survive"))

# Convert to data frame
titanic_summary <- as.data.frame(titanic_summary)

# Create the interactive stacked bar plot
plot <- plot_ly(titanic_summary, 
                x = ~pclass, 
                y = ~percentage, 
                type = 'bar', 
                color = ~as.factor(survived),
                text = ~paste('Status:', survival_status, '<br>Percentage:', round(percentage, 2), '%'),
                hoverinfo = 'text',
                textposition = 'auto') %>%
  
  layout(barmode = 'stack',
         xaxis = list(title = 'passenger Class'),
         yaxis = list(title = 'Percentage'),
         title = 'Survival Proportions by passenger Class',
         legend = list(title = list(text = 'Survival Status')))

# Create a scatter plot of Age vs. Fare colored by Embarkation
ggplot_scatter <- ggplot(titanic_data, aes(x = age, y = fare, color = embarked)) +
  geom_point() +
  xlab("Age") +
  ylab("Fare") +
  ggtitle("Scatter Plot of Age vs. Fare by Embarkation") +
  theme_minimal()


# Display the plot
ggplot_scatter

# Filter the dataframe for passengers who embarked at Southampton
southampton_data <- titanic_data %>%
  filter(embarked == "S")

# Scatter Plot of Age vs Fare
ggplot(southampton_data, aes(x = age, y = fare)) +
  geom_point(color = "red") +
  geom_smooth(method = "lm", col = "blue") +
  xlab("Age") +
  ylab("Fare") +
  ggtitle("Scatter Plot of Age vs. Fare for Southampton")
