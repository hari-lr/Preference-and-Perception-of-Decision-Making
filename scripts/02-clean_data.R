```{r}
#### Preamble ####
# Purpose: Replicate the "Inaction We Trust" Study 2 data cleaning by "Adrien Fillon"
# Author: Hari Lee Robledo, Sky Suh and Francesca Ye
# Date: 10 February 2024
# Pre-requisites: Download "Inaction We Trust" Study 2 data
```

#### Workspace setup ####
```{r setup, include=FALSE}
# Code referenced from: https://osf.io/kzf3x
knitr::opts_chunk$set(warning = FALSE, message = FALSE) 

list.of.packages <- c("report", "dplyr", "psych", "ggplot2", "tidyverse", "corrr", "corrplot", "PerformanceAnalytics", "Hmisc", "ggstatsplot", "jtools", "metan", "ggstatsplot", "ggthemes", "apaTables","insight", "parameters")
new.packages <- list.of.packages[!(list.of.packages %in% installed.packages()[
  ,"Package"])]
if(length(new.packages)) install.packages(new.packages, dependencies = TRUE)
invisible(lapply(list.of.packages, library, character.only = TRUE))

# setting formatting options
options(scipen=999, digits =3)
```

#### Read Data ####
```{r study 2, echo=FALSE}
# Code referenced from: https://osf.io/kzf3x
data2 <- read.csv("study_2_raw_data.csv",sep = ";" )
```

#### Clean Data ####
# Code referenced from: https://osf.io/kzf3x
```{r descriptives2}
# Code referenced from: https://osf.io/kzf3x
## remove variable descriptions + practice data

data2 <-  data2 [, c("expect", "preference", "competence", "descriptive.norms", "Injunctive", "regret", "joy", "check", "gender", "age", "condition")]
data2 <- mutate_all(data2, function(x) as.numeric(as.character(x)))


S2Control <- data2 %>% filter (condition == 1)

summary2 <- S2Control %>%
    select(preference, competence, descriptive.norms, Injunctive, regret, joy, age, gender) %>% 
  psych::describe(quant=c(.25,.75)) %>% as_tibble(rownames="rowname")
knitr::kable(summary2, digits=2, caption = "Summary descriptives", align = "c")
tablegender2<-table(S2Control$gender)
knitr::kable(tablegender2, digits=2, caption = "Summary gender", align = "c")

dplot2 <- S2Control %>% 
  select(preference, competence, descriptive.norms, Injunctive, regret, joy) %>%
  rename(Preference = preference, Competence = competence,
         "Descriptive norms" = descriptive.norms,
         "Injunctive norms" = Injunctive, Regret = regret, Joy = joy)%>%
  gather()
dplot2$key<-factor(dplot2$key, levels = c("Preference","Competence",
                                          "Descriptive norms", "Injunctive norms",
                                          "Regret", "Joy"))


#Distribution Graphs
# Code referenced from: https://osf.io/kzf3x

S2preferenceplot <- ggstatsplot::gghistostats(
  data = S2Control, # data from which variable is to be taken
  x = preference, # numeric variable
  xlab = "Preference", # x-axis label
  # title = "Preference", # title for the plot
  test.value = 0, # test value
  #caption = "Data courtesy of: SAPA project (https://sapa-project.org)"
) + theme_minimal()
S2preferenceplot

S2competenceplot <- ggstatsplot::gghistostats(
  data = S2Control, # data from which variable is to be taken
  x = competence, # numeric variable
  xlab = "Competence", # x-axis label
  title = "Competence", # title for the plot
  test.value = 0,
   #caption = "Data courtesy of: SAPA project (https://sapa-project.org)"
  ) + theme_minimal()
S2competenceplot

S2desnormativeplot <- ggstatsplot::gghistostats(
  data = S2Control, # data from which variable is to be taken
  x = descriptive.norms, # numeric variable
  xlab = "Descriptive norms", # x-axis label
  # title = "Norms", # title for the plot
  test.value = 0, # test value
  #caption = "Data courtesy of: SAPA project (https://sapa-project.org)"
)+ theme_minimal()
S2desnormativeplot

S2injnormativeplot <- ggstatsplot::gghistostats(
  data = S2Control, # data from which variable is to be taken
  x = Injunctive, # numeric variable
  xlab = "Injunctive norms", # x-axis label
  test.value = 0, # test value
  #caption = "Data courtesy of: SAPA project (https://sapa-project.org)"
)+ theme_minimal()
S2injnormativeplot

S2regretplot <- ggstatsplot::gghistostats(
  data = S2Control, # data from which variable is to be taken
  x = regret, # numeric variable
  xlab = "Regret", # x-axis label
  test.value = 0, # test value
  #caption = "Data courtesy of: SAPA project (https://sapa-project.org)"
) + theme_minimal()
S2regretplot

S2joyplot <- ggstatsplot::gghistostats(
  data = S2Control, # data from which variable is to be taken
  x = joy, # numeric variable
  xlab = "Joy", # x-axis label
  test.value = 0, # test value
  #caption = "Data courtesy of: SAPA project (https://sapa-project.org)"
) + theme_minimal()
S2joyplot
```

```{r}
#Merged Graphs

dplot2 %>% ggplot(aes(value)) + 
  facet_wrap(~ key, scales = "free")+ geom_bar(binwidth = 1)+theme_apa()+
  labs(x = "", y = "")+ scale_x_discrete(limits = c(-5,0,5))+ ylim(0, 250) 
```