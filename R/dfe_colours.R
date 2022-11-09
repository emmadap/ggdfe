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

  grDevices::colorRampPalette(pal, ...)

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
#' @examples library(ggplot2)
#' iris |>
#' ggplot(aes(x=Sepal.Width, y=Sepal.Length, colour = Species))+
#' geom_point()+
#' scale_colour_dfe()
#'
#' iris |>
#'  ggplot(aes(x=Petal.Length,y=Sepal.Length,colour = Sepal.Width))+
#'  geom_point(size = 3, alpha = 3/4)+
#'  scale_colour_dfe(palette = 'heat', discrete = FALSE)
#'
#'
scale_colour_dfe <- function(palette = "main",
                             discrete = TRUE,
                             reverse = FALSE,
                             ...){
  pal <- dfe_pal(palette = palette, reverse = reverse)

    if (discrete){
      ggplot2::discrete_scale("colour", paste0("dfe_", palette), palette = pal, ...)
    } else {
      ggplot2::scale_colour_gradientn(colours = pal(256))
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
#' @examples library(ggplot2)
#' iris |>
#'  ggplot(aes(x=Species,y=Sepal.Length,fill=Species))+
#'  geom_col()+
#'  scale_fill_dfe()
#'
#'
#'  ggplot(faithfuld, aes(waiting, eruptions, fill = density)) +
#'      geom_tile()+
#'      scale_fill_dfe(discrete = FALSE, palette = 'heat')
#'
scale_fill_dfe <- function(palette = "main", discrete = TRUE, reverse = FALSE, ...) {
  pal <- dfe_pal(palette = palette, reverse = reverse)

  if (discrete) {
    ggplot2::discrete_scale("fill", paste0("dfe_", palette), palette = pal, ...)
  } else {
    ggplot2::scale_fill_gradientn(colours = pal(256), ...)
  }
}



#this should be an undocumented function at the moment, but it could be developed in the future
#Plays the same role as Rcolorbrewer::display.brewer.all()
#but in ggplot
#You can also pass individual palettes such as dfe_palettes["full"]

display.dfe.all <- function(name_of_palette = dfe_palettes){


  purrr::pluck(tibble::tibble(name_of_palette),1) -> pal_data

  output <- tibble::tibble()
  pal_colour <- ord <- NULL

  for(i in seq_along(pal_data)){

    name <- names(pal_data[i])
    pal <-  unlist(purrr::pluck(pal_data[i]))

    for(i in seq_along(pal)){
      output <- dplyr::bind_rows(output, c(name = name, pal_colour = pal[[i]], ord = i))
    }
  }

  cols <- levels(factor(output$pal_colour))


  ggplot2::ggplot(data = output, ggplot2::aes(x=ord,y=stats::reorder(name,ord, FUN = max),fill = pal_colour))+
    ggplot2::geom_tile(height = .8, width = .8, colour = 'black')+
    ggplot2::scale_fill_manual(values = cols)+
    ggplot2::coord_fixed(ratio = 9/16)+
    ggplot2::theme_minimal()+
    ggplot2::theme(panel.grid = ggplot2::element_blank(),
          axis.text.x = ggplot2::element_blank(),
          axis.title = ggplot2::element_blank(),
          legend.position = 'none') -> plot

  return(plot)

}


