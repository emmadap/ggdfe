# dfethemes

This package seeks to create an easy theme to add to any ggplot to keep it in line with ['DfE brand guidelines'](https://educationgovuk.sharepoint.com/sites/how-do-i/SitePages/communications-how-to-use-branding-in-the-department-and-its-executive-agencies.aspx?xsdata=MDV8MDF8fGFkNzQzOGRkZWUwNjQ5NWRlOTIwMDhkYWJjMmE0ZTQ1fGZhZDI3N2M5YzYwYTRkYTFiNWYzYjNiOGIzNGE4MmY5fDF8MHw2MzgwMjkxODcxMTQxOTkzMjh8R29vZHxWR1ZoYlhOVFpXTjFjbWwwZVZObGNuWnBZMlY4ZXlKV0lqb2lNQzR3TGpBd01EQWlMQ0pRSWpvaVYybHVNeklpTENKQlRpSTZJazkwYUdWeUlpd2lWMVFpT2pFeGZRPT18MXxNVGs2TXpFeFpXTXlaVFJrTkRaaU5HUmtNemhtTUdRMk1XWXdOV1ppT1RNek9ETkFkR2h5WldGa0xuTnJlWEJsfHw%3D&sdata=YzJ6TWJBT0Z1cXduTUhsenZIQ1E5VzUrSjM2Q3lDZlN1TWRvZlNvdWhYMD0%3D#using-the-brand).

## Colours

There are two functions that work to add in colour scales: `scale_fill_dfe()` and `scale_colour_dfe()`. These replace the usual `scale_colour_*()` and `scale_fill_*()` functions to change colours on ggplot. 

These are the base colours

![](assets/dfe_colour_palette.png)


There are also palettes, passed to the 'palettes' argument. These are for selecting a suitable subset of the colours above, depending on if you need a discrete, continuous or diverging palette.

main - Blue red turquoise (discrete, 3 colours)
warm - Red to purple (continuous)
cool - Blue to lime (continuous)
full - all colours in the brand (discrete, 7 colours)
likert - red to blue, grey midpoint (diverging)
likert2 - green to purple, white midpoint (diverging)
likert3 -  red to blue, white midpoint (diverging)
heat - white to red (continuous)
heat2 - white to pink (continuous)
cold - white to blue (continuous)
cold2 - white to turqouise (continuous








