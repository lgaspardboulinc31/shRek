
library(ggpubr)
# make all palette plot
plotlist_hero= list()
plotlist_villain = list()
plotlist_places = list()
for (palette in names(hero_palettes)){
  plotlist_hero[[palette]]=show_my_swamp(burp(palette, pal_class = "Hero"))
}
for (palette in names(villain_palettes)){
  plotlist_villain[[palette]]=show_my_swamp(burp(palette, pal_class = "Villain"))
}
for (palette in names(place_palettes)){
  plotlist_places[[palette]]=show_my_swamp(burp(palette, pal_class = "Place"))
}


ggarrange(plotlist = plotlist_hero, ncol=3, nrow=3)
ggsave("./images/all_colors_hero.png", width=15, height = 10)

ggarrange(plotlist = plotlist_villain, ncol=2, nrow=2)
ggsave("./images/all_colors_villain.png", width=10, height = 6)


ggarrange(plotlist = plotlist_places, ncol=2, nrow=2)
ggsave("./images/all_colors_places.png", width=10, height = 6)



