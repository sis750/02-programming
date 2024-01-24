#+ Statistical programming in R
#+ Austin Hart
#+ Spring 2024


# Packages -------------
## attaching a library (for installed package)
  library(tidyverse)

## accessing a function on the fly
  df = readr::read_csv('trash_wheels.csv')


# Directories ----------
## Check and set your directory (outside of R project)
  getwd() # where's my current directory?
  setwd('file path')

## what's in my folder?
  list.files()


# Data I/O -------------
## Import our trash wheel data
  df = read_csv('trash_wheels.csv')

## compare two alternatives:
  read_csv(file = 'trash_wheels.csv')
  df2 = read_csv(file = 'trash_wheels.csv')

## Output
  save(df1, 'newdata.RData')
  write_csv(df1, 'newdata.csv')  

#+ WARNINGS: 
#+ Please avoid read.csv() 
#+ Do not use point + click for Data I/O


# Explore --------------
## Structure of a data frame
  str(df)
  summary(df)  

## character/factor vars ----
### frequency table
  tab1 = df |>
    count(wheel, name = 'N') |>
    mutate(Per = N / sum(N) * 100)

### Beautify the table for printing
  tab1 |>
    knitr::kable(digits = 1L) # optional last step

# Graphing
  plot1 = tab1 |>
    ggplot(aes(x = wheelName, y = percent)) +
    geom_col()  


## numeric vars --------
### Summary stats
  summary(df['cigarettes'])
  
  df |> # get summary stats
    summarize(
      AvgCigs = mean(cigarettes, na.rm = T),
      AvgBottles = mean(plastic_bottles, na.rm = T),
      Diff = mean(cigarettes, na.rm = T) - mean(plastic_bottles, na.rm = T)
    )

### Plot the distribution    
  df |>
    ggplot(aes(x = plastic_bags)) +
    geom_histogram(color = 'white') # compare to geom_boxplot()    


# Objects --------------
## Vectors/values
  a = letters[1:10] # check type: is(a)
  b = 100:109

## Data frames/tibbles
  df1 = data.frame(a, b)
  df2 = tibble(b, a)
  l1 = list(d1 = df1, d2 = df2)

## Extract an item from list or frame
  ex1 = df1$b
  ex2 = df1[['b']]
  ex3 = 
    df1 |> 
    pull(b)

## Subset an element (maintains structure)
  sub1 = df1[2]
  sub2 = df1['b'] # use quotes to call by name
  sub3 = df1[1:4, 'b'] # select rows 1-4, variable 'b'
  sub4 = 
    df1 |>
    select(b) |>
    filter(b <= 103)  

  
#+ MAIN FUNCTIONS ENCOUNTERED
#+ read_***() to input data
#+ mutate() to create new variables in df
#+ select() to select subset of variables from df  
#+ filter() to select subset of cases from df
#+ = or <- to assign new objects
#+ $ and [[]] to select/extract element of object
#+ [] to subet object

