library(grid)
library(gridExtra)
library(data.table)

df <- read.csv("diciembre.csv")

# example data & header row
tab <- tableGrob(df, rows=NULL)
header <- tableGrob(df[1, 1:2], rows=NULL) 

jn <- gtable_combine(header[1,], tab, along=2)
jn$widths <- rep(max(jn$widths), length(jn$widths)) # make column widths equal
#grid.newpage()
grid.draw(jn) # see what it looks like before altering gtable

# change the relevant rows of gtable
jn$layout[1:4 , c("l", "r")] <- list(c(1, 3), c(2, 4))

grid.newpage()
grid.draw(jn)


# Second ------------------------------------------------------------------


library(gt)
library(tidyverse)

dates <- seq(as.Date('2020-12-01'),as.Date('2020-12-31'),by = 1)
links <- rep("http://200.10.244.22:8080/data/basetest.txt", 31)


df <- data.frame(
  Fecha = dates,
  link = links)


# using markdown
df <- df %>%
  mutate(
    link = glue::glue("[website]({link})"),
    link = map(link, gt::md)) %>%
  gt() %>%
  tab_header(
    title = "Diciembre")
