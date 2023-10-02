


#' @title Heroes' palettes
#' @description List of palettes inspired from Heroes
#' @export

hero_palettes <- list(
  Shrek = c("#B0C400","#D5DE2E","#795A2D","#523213","#C3BC95","#D3CCA5"),
  Fiona = c("#DEC33E", "#C0B037", "#A25E2E", "#5A5832", "#53432A", "#40473C"),
  # Donkey = ,
  Puss_in_Boots =c("#F0B56E", "#F4983F", "#B58421", "#6E342C", "#624835", "#90837A"),
  Dragon = c("#809737", "#CE603D", "#C25866", "#953644", "#A3534D", "#A80216"),
  Gingy = c("#CD524F", "#C5812A", "#BCA7A0", "#6F748C", "#864590"),
  Pinocchio= c("#E7B621", "#730000", "#007DAD", "#DCBB82", "#746225")
)

#' @title Villains' palettes
#' @description list of palettes inspired from Villain
#' @export

 villain_palettes <- list(
  Fairy_Godmother=c("#617F95", "#4E6C7F", "#A4AEBE", "#B1C9E0", "#E6CFDE", "#D69D9E"),
   Charming =c("#EEECD8", "#C49F3C", "#3698B7", "#596979", "#032A5C", "#0E1319"),
   Lord_Farquaad=c("#FFB841", "#D8332F", "#B50128", "#A69D7B", "#0F5381", "#050917"),
   Rumpelstiltskin = c("#C8562A", "#5E7E72", "#946D58", "#EAA13D", "#594B3A", "#AE6441")
)

 #' @title Places' palettes
 #' @description list of palettes inspired from Places
 #' @export
place_palettes <- list(
  Duloc = c("#72767D", "#D2D0BD", "#AEB5C3", "#737F9D", "#262C44", "#181B17"),
  Far_Far_Away = c("#929BD4", "#F2C27F", "#CE9671", "#893F31", "#AC9E54", "#373F0D"),
  Dragon_Keep = c("#E31A2D", "#C20F33", "#813666", "#584B96", "#542F4D", "#2C304A"),
  Swamp=c("#B27D4B", "#9A872C", "#465013", "#2F3A13", "#605324", "#222612")#,
)


#' @title Information about the Colour Palettes
#' @description This dataframe contains the backstory or inspiration behind each color palette.
#'
info <- data.frame(
  palette_name=c(
    #heroes
      "Shrek",
      "Fiona",
      "Donkey",
      "Puss_in_Boots",
      "Dragon",
      "Gingy",
      "Pinocchio",

      #vilains
      "Fairy_Godmother",
      "Charming",
      "Lord_Farquaad",
      "Rumpelstiltskin",

      #places
      "Duloc",
      "Far_Far_Away",
      "Dragon_Keep",
      "Swamp"

      ),

  bio=c(
    #heroes
    "Our hero",
    "The badass girl",
    "Shrek's best friend",
    "Shrek's adopted best friend",
    "The keeper of Fiona and Donkey's lover",
    "The bravest cookie",
    "More human than you think",
    # vilain
    "The vilain in Shrek 2",
    "The handsome son of Fairy Godmother",
    "The vilain in Shrek 1",
    "The vilain in Shrek 3",
    #places
    "Lord Farquaad's castle",
    "Fiona's parent kingdom",
    "Where Fiona has been locked",
    "Shrek's House"

  )
)


#' Select a color palette
#'
#' @param name A string corresponding to one of the available palette.
#' @param pal_class A string between Hero, Villain or Place
#' @param n A number of color
#' @param type A string
#' @return A color palette in a form of a vector
#' @examples burp("Shrek", pal_class="Hero", n=5)
#' @examples burp("Lord_Farquaad", pal_class="Villain", n=6)
#' @export

burp <- function(name,pal_class=c("Hero","Villain","Place"), n, type = c("discrete", "continuous")) {
  type <- match.arg(type)

  if (pal_class == "Hero"){
    palettes=hero_palettes
    }
  else{
      if (pal_class == "Villain"){
        palettes=villain_palettes
      }
      else{
        palettes=place_palettes
      }
    }

  pal <- palettes[[name]]
  if (is.null(pal))
    stop("We do not have a palette with this name.")

  if (missing(n)) {
    n <- length(pal)
  }

  if (type == "discrete" && n > length(pal)) {
    stop("Number of requested colors greater than what palette can offer")
  }

  out <- switch(type,
                continuous = grDevices::colorRampPalette(pal)(n),
                discrete = pal[1:n]
  )

  structure(out, class = "palette", name = name)
}



#' @title Plot a color palette
#' @param pal A color palette
#' @return A ggplot objects
#' @export
#' @import ggplot2
#' @import dplyr

#' @examples
#' shrek_pal = burp("Shrek", pal_class="Hero", n=6)
#' show_my_swamp(shrek_pal)

show_my_swamp<- function(pal) {

  # Info df imported while loading package
  info_sub = info %>%
    filter(palette_name == attributes(pal)$name)

  n <- length(pal)
  df <- data.frame(xvals = c(1:n), yvals = rep(1, n), text = pal[1:n])

  ggplot(df, aes(x = xvals, y = yvals)) + #specifiy axis
    geom_tile(fill = pal,
              colour = "white",
              linewidth = 3) +
    geom_text(aes(label=text), color="black", nudge_y = -1) +
    theme_void() +
    coord_fixed(ratio=1) + #allow constant ratio x/y
    theme(plot.title = element_text(hjust = 0.5, face="bold", size=20), #custom titles
          plot.subtitle = element_text(hjust = 0.5, size=15, face="italic"),
          legend.position = "none") +
    labs(title = info_sub$palette_name, subtitle = info_sub$bio) +
    theme(plot.margin = margin(0.5,0.5,1,0.5, "cm"))
}


