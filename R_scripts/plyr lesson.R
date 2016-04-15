install.packages('dplyr')
library(dplyr)

dat <- read.csv(file.choose())

View(dat)
head(dat)
#in dplyr
glimpse(dat)
dim(dat)

#pick individual columns, these functions are from dplyr
select(dat, order, species)
select(dat, starts_with('adult'))
select(dat, -order)

#pick individual rows
filter(dat, order=="Carnivora")
filter(dat, order=="Carnivora" & adult_body_mass_g<5000)

#arranges smallest to largest
arrange(dat, adult_body_mass_g)
arrange(dat, desc(adult_body_mass_g))

dat.1 <- arrange(dat, adult_body_mass_g)
head(dat.1)

#find average mass per Order
#group by order
a = group_by(dat, order)
#summarize, each group has mean adult body mass
b = summarize(a, mean_mass = mean(adult_body_mass_g, na.rm = TRUE))
b
#put this info as a new column in dataset
c = mutate(a, mean_mass = mean(adult_body_mass_g, na.rm = TRUE))
head(c)
View(c)
#add sd
d <- summarize(a, mean_mass = mean(adult_body_mass_g, na.rm = TRUE), 
              sd_mass = sd(adult_body_mass_g, na.rm = TRUE))
e <- mutate(a, mean_mass = mean(adult_body_mass_g, na.rm = TRUE),
           norm_mass = adult_body_mass_g/mean_mass)
head(e)
View(e)
#can nest this, but it can get very confusing
e <- mutate(group_by(dat, order), mean_mass = mean(adult_body_mass_g, na.rm = TRUE),
            norm_mass = adult_body_mass_g/mean_mass)
#pipe
e <- dat %>% #take our data
  group_by(order) %>% #split it up by order
  mutate(mean_mass = mean(adult_body_mass_g, na.rm = TRUE), norm_mass = adult_body_mass_g/mean_mass) %>%
  arrange(desc(norm_mass))
View(e)  

#which order has the most species
f <- dat %>%
  group_by(order) %>%
  summarize(species_num = length(species)) %>%
  arrange(desc(species_num))
View(f)

#which order has widest range of body mass
range_size_sp <- dat %>%
  group_by(order) %>%
  summarize(mass_range = max(adult_body_mass_g, na.rm = TRUE) - min(adult_body_mass_g, na.rm = TRUE)) %>%
  arrange(desc(mass_range))
View(range_size_sp)

#which species of carivore has largest body body length to body mass?
carn_ratio <- dat %>%
  filter(order=="Carnivora") %>%
  mutate(mass_ratio = adult_head_body_len_mm/adult_body_mass_g) %>%
  arrange(desc(mass_ratio))
View(carn_ratio)

#lists columns
dat$order
#blah

