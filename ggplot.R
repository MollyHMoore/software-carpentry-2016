##ggplot
#grammar of graphics
install.packages("ggplot2", dependencies = TRUE)  
library(ggplot2)
library(dplyr)

mammals <- read.csv(file.choose())

#without ggplot
plot(adult_head_body_len_mm~adult_body_mass_g, data=mammals)

#with ggplot
ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm)) + geom_point()

#parts of ggplot
# function is ggplot()
# arguments: need data, aes (aesthetic,how to arrange data points), geom(what form it's in)
# can have: stats, facets, scales, theme

#can assign to a variable
my_plot <- ggplot()

#data -- must be dataframe
#aes -- specify x and y, map variable to part of figure
#geom -- way to plot data, nothing in parentheses = default method

ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm)) + geom_point()

#add log scale
ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm)) + 
  geom_point() + scale_x_log10()

#also geom_line, geom_boxplot, geom_hist

#can specify color, etc in aes
ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm)) + 
  geom_point(size = 3, aes(size=litter_size)) + scale_x_log10()
ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm)) + 
  geom_point(size = 3, aes(color=order)) + scale_x_log10()

#histogram
ggplot(data=mammals, aes(x=adult_body_mass_g)) + geom_histogram() + scale_x_log10()

#faceting
ggplot(data=mammals, aes(x=adult_body_mass_g, y=adult_head_body_len_mm)) + 
  geom_point(size = 3, aes(size=litter_size)) + scale_x_log10() + 
  facet_wrap(~order)

#create new categorical variable
mammals$RangeCategory[mammals$home_range_km2 <= 0.01] <- "micro_machines"
mammals$RangeCategory[mammals$home_range_km2 > 0.01 & mammals$home_range_km2 <= 1] <- "homebodies"
mammals$RangeCategory[mammals$home_range_km2 > 0.1 & mammals$home_range_km2 <= 10] <- "strollers"
mammals$RangeCategory[mammals$home_range_km2 > 10 & mammals$home_range_km2 <= 100] <- "roamers"
mammals$RangeCategory[mammals$home_range_km2 > 100 & mammals$home_range_km2 <= 1000] <- "free_agents"
mammals$RangeCategory[mammals$home_range_km2 > 1000] <- "transcendentalists"

head(mammals$RangeCategory)

OrderSubset<-filter(mammals, order == "Rodentia" | order == "Cetacea" | order=="Primates" | order=="Carnivora") 
#display in order set by me
OrderSubset$RangeCategory <- factor(OrderSubset$RangeCategory, levels = c("micro_machines", "homebodies", "strollers", "roamers", "free_agents", "transcendentalists"))
OrderSubset$order <- factor(OrderSubset$order, levels = c("Rodentia", "Carnivora", "Primates", "Cetacea"))

ggplot(data=OrderSubset, aes(x = adult_body_mass_g)) + geom_histogram(aes(fill=order)) +
  scale_x_log10() + facet_grid(RangeCategory~order, scales="free")

#challenge
OrderSubset<-filter(mammals, order == "Rodentia" | order == "Artiodactyla" | order=="Primates" | order=="Carnivora") 
#display in order set by me
OrderSubset$RangeCategory <- factor(OrderSubset$RangeCategory, levels = c("micro_machines", "homebodies", "strollers", "roamers", "free_agents", "transcendentalists"))
OrderSubset$order <- factor(OrderSubset$order, levels = c("Rodentia", "Carnivora", "Primates", "Artiodactyla"))

ggplot(data=OrderSubset, aes(x = adult_body_mass_g, y = order)) + geom_boxplot(aes(fill=order)) +
  scale_x_log10() + facet_grid(RangeCategory~order, scales="free")

ggplot(data=OrderSubset, aes(y = order,x = adult_body_mass_g)) + geom_violin(aes(fill=order)) +
  scale_x_log10() + facet_grid(RangeCategory~order, scales="free")

#statistics
ggplot(data=OrderSubset, aes(x=adult_body_mass_g, y=litter_size))+  
  geom_point(aes(color=order))+  
  scale_x_log10()+
  facet_grid(RangeCategory~order, scales ="free") +
  geom_smooth(method=lm)


#themes
ggplot(data=OrderSubset, aes(x=adult_body_mass_g))+
  geom_histogram(aes(fill=order))+
  scale_x_log10()+
  facet_grid(RangeCategory~order, scales="free")+
  theme(legend.key=element_rect(fill=NA), 
  legend.position="bottom", axis.title=element_text(angle=0, size=18, face="bold"),
  legend.text=element_text(angle=0, size=12, face="bold"),
  panel.background=element_rect(fill=NA))

install.packages("wesanderson")
library(wesanderson)

wes_palette("Royal1")
wes_palette("FantasticFox")
wes_palette("Zissou")

ggplot(data=OrderSubset, aes(x=adult_body_mass_g))+
  geom_histogram(aes(fill=order), color="black")+
  scale_x_log10()+
  facet_grid(RangeCategory~order, scales="free")+
  scale_fill_manual(values=wes_palette("Royal1"))+
  theme_bw() +
  theme(legend.key=element_rect(fill=NA), 
        legend.position="bottom", axis.title=element_text(angle=0, size=18, face="bold"),
        legend.text=element_text(angle=0, size=12, face="bold"),
        panel.background=element_rect(fill=NA))
