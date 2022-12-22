library(ggplot2)
library(tidyverse)
library(extrafont)

# TODO: Read though Chapter 2 of https://r-pkgs.org/whole-game.html

# Colours, to be replaced by dfe colour palettes
dfe_navy <- "#183860"

# Bar Chart
mpg %>%
  ggplot(aes(manufacturer)) +
  geom_bar(fill = dfe_navy) +
  xlab("X Axis Label") +
  ylab("Y Axis Label") +
  labs(title = "Short Title",
       subtitle = "A long title with more information and context") +
  theme(axis.text.x = element_text(angle = 30),
        plot.title = element_text(family = "Times New Roman"))

font_import()
y
