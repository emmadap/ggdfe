require(tidyverse)


#These are the colours used - here's the brand guidelines: https://educationgovuk.sharepoint.com/sites/how-do-i/SitePages/communications-how-to-use-branding-in-the-department-and-its-executive-agencies.aspx#using-the-brand

dfe_colours <- c(
  "Blue" = "#183860",
  "Red" = "#EB5C5D",
  "Turquoise" = "#2BBAD9",
  "Lime" = "#A3D55F",
  "Pink" = "#DF7CB0",
  "Purple" = "#774B99",
  "Yellow" = "#f6da40",
  "White" = "#ffffff",
  "Grey" = "#e5e5e5"
  )


#this just selects colours based on the names - used to create palettes below
dfe_cols <- function(...){
  cols <- c(...)

  if (is.null(cols))
    return(dfe_colours[])

  dfe_colours[cols]
}

#list of palettes for various types
dfe_palettes <- list(
  "main" = dfe_cols("Blue","Red","Turquoise"),
  "warm" = dfe_cols("Red","Pink","Purple"),
  "cool" = dfe_cols("Blue", "Turquoise", "Lime"),
  "full" = dfe_cols("Red","Pink","Yellow","Lime","Turquoise", "Blue", "Purple"),
  "likert" = dfe_cols("Red","Grey","Turquoise"),
  "likert2" = dfe_cols("Lime","White","Purple"),
  "likert3" = dfe_cols("Red","White","Blue"),
  "heat" = dfe_cols("White","Red"),
  "heat2"= dfe_cols("White","Pink"),
  "cold" = dfe_cols("White","Blue"),
  "cold2"= dfe_cols("White", "Turquoise")
)

#function to create the palette
dfe_pal <- function(palette = 'main',
                    reverse = FALSE,
                    ...){
  pal <- dfe_palettes[[palette]]

  if(reverse) pal <- rev(pal)

  colorRampPalette(pal, ...)
}

#' Add colour scale to ggplot with DfE theme
#'
#' @param palette The colour palette to use
#' @param discrete Is the scale discrete (defaults TRUE)
#' @param reverse Reverse the order of the scale (defaults FALSE)
#' @param ... arguments passed onto discrete_scale
#'
#' @return These are the palettes in their current form \cr
#'  main - Blue red turquoise (discrete, 3 colours) \cr
#'  warm - Red to purple (continuous) \cr
#'  cool - Blue to lime (continuous) \cr
#'  full - all colours in the brand (discrete, 7 colours) \cr
#'  likert - red to blue, grey midpoint (diverging) \cr
#'  likert2 - green to purple, white midpoint (diverging) \cr
#'  likert3 -  red to blue, white midpoint (diverging) \cr
#'  heat - white to red (continuous) \cr
#'  heat2 - white to pink (continuous) \cr
#'  cold - white to blue (continuous) \cr
#'  cold2 - white to turqouise (continuous)\cr
#' @export
#' @examples iris %>% ggplot(aes(x=Sepal.Width, y=Sepal.Length, colour = species))
#' + geom_point()+
#' scale_colour_dfe()
#'
#' iris %>%
#'  ggplot(aes(x=Petal.Length,y=Sepal.Length,colour = Sepal.Width))+
#'  geom_point(size = 3, alpha = 3/4)+
#'  scale_colour_dfe(palette = 'heat', discrete = F)
#'
#'
scale_colour_dfe <- function(palette = "main",
                             discrete = TRUE,
                             reverse = FALSE,
                             ...){
  pal <- dfe_pal(palette = palette, reverse = reverse)

    if (discrete){
      discrete_scale("colour", paste0("dfe_", palette), palette = pal, ...)
    } else {
      scale_colour_gradientn(colours = pal(256))
    }
  }

#' Add fill scale to ggplot with DfE theme
#'
#' @param palette The colour palette to use
#' @param discrete Is the scale discrete (defaults TRUE)
#' @param reverse Reverse the order of the scale (defaults FALSE)
#' @param ... arguments passed onto discrete_scale or scale_fill_gradientn
#'
#' @return These are the palettes in their current form \cr
#'  main - Blue red turquoise (discrete, 3 colours) \cr
#'  warm - Red to purple (continuous) \cr
#'  cool - Blue to lime (continuous) \cr
#'  full - all colours in the brand (discrete, 7 colours) \cr
#'  likert - red to blue, grey midpoint (diverging) \cr
#'  likert2 - green to purple, white midpoint (diverging) \cr
#'  likert3 -  red to blue, white midpoint (diverging) \cr
#'  heat - white to red (continuous) \cr
#'  heat2 - white to pink (continuous) \cr
#'  cold - white to blue (continuous) \cr
#'  cold2 - white to turqouise (continuous)\cr
#' @export
#' @examples iris %>%
#'  ggplot(aes(x=Species,y=Sepal.Length,fill=Species))+
#'  geom_col()+
#'  scale_fill_dfe()
#'
#'
#' data <- data.frame(murder = USArrests$Murder,
#'  state = tolower(rownames(USArrests)))
#'  map <- map_data("state")
#'  ggplot(data, aes(fill=murder))+
#'    geom_map(aes(map_id = state), map=map)+
#'    expand_limits(x = map$long, y=map$lat)+
#'    scale_fill_dfe(palette = 'heat',discrete = F)
#'
#'
#'
scale_fill_dfe <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- dfe_pal(palette = palette, reverse = reverse)

  if (discrete) {
    discrete_scale("fill", paste0("dfe_", palette), palette = pal, ...)
  } else {
    scale_fill_gradientn(colours = pal(256), ...)
  }
}
