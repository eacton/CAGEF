library(tidyverse)

dat <- read_csv("data/long_SPE_pitlatrine.csv", col_types = 'ccici')

ndat <- read_csv("data/split_ENV_pitlatrine.csv", col_types = 'cccnnnn')

ggplot(ndat, mapping = aes(x = TS, y = CODt, color = Temp, shape = Country)) + geom_point() + scale_y_log10() + facet_wrap(~Depth, scales = "free_y")

#ggplot(ndat, mapping = aes(x = TS, y = log10(CODt), color = Country)) + geom_point() 

ggplot(ndat, aes(TS, CODt)) +
  geom_point(alpha = 0.3) +
  scale_y_log10() +
  facet_grid(~Country) +
  stat_smooth(method = loess, level = 0.8)

ggplot(fdat, aes(x = OTUs, fill = Country, alpha = 0.3)) + geom_density() + xlim(0, 1000) + geom_rug()

fdat <- dat %>% filter(OTUs >=2)

ggplot(fdat, aes(x = OTUs, fill = Country, alpha = 0.3)) + 
  geom_histogram(binwidth = 50, position = "dodge") +
  xlim(0, 1000) + 
  geom_rug() +
  ylim(0, 150)

ggplot(fdat, aes(Country, OTUs, fill = fct_reorder2(Taxa, Country, OTUs))) +
  geom_bar(stat = "identity") +
  coord_flip()

ggplot(dat, aes(Taxa, OTUs)) +
  geom_boxplot() +
  theme(axis.text.x =element_text(angle = 90, hjust = 1)) + scale_y_log10()


keep <- fdat %>%
  group_by(Country, Taxa) %>%
  summarize(n = n()) %>%
  filter(n>1) %>%
  ungroup() %>%
  select(Taxa) %>%
  filter(duplicated(.))

subfdat <- fdat %>% filter(Taxa %in% keep$Taxa)

ggplot(subfdat, aes(Taxa, OTUs)) +
  geom_boxplot() +
  theme(axis.text.x =element_text(angle = 90, hjust = 1)) + scale_y_log10() +
  facet_grid(~Country)

subdat <- dat %>% filter((Taxa == "Clostridia" | Taxa =="Unknown" | Taxa == "Bacilli") & Country == "T")


b <- ggplot(subdat, aes(Taxa, OTUs)) +
  geom_boxplot() +
  theme(axis.text.x =element_text(angle = 90, hjust = 1)) + scale_y_log10()

library(ggbeeswarm)

b + geom_beeswarm(cex = 2.2)

b + geom_quasirandom(varwidth = TRUE)

labels <- c(T = "Tanzania", V = "Vietnam")

p <- ggplot(subfdat, aes(Taxa, OTUs, fill = Taxa)) +
  geom_boxplot(outlier.color = "red") +
  theme(axis.text.x =element_text(angle = 90, hjust = 1)) + scale_y_log10() +
  facet_grid(~Country, labeller = labeller(Country = labels)) +
  ggtitle("Abundance of Taxa by Country") +
  ylab("log(OTUs)") +
  xlab(NULL) +
  guides(fill = FALSE)
  
library(RColorBrewer)
display.brewer.all(type = "qual")

p + scale_fill_brewer(palette = "Spectral")

palette1 <- brewer.pal(12, "Paired")
palette2 <- brewer.pal(12, "Set3")

custom <- c(palette1, palette2)
length(unique(custom))

p + scale_fill_manual(values = custom)

scale_fill_manual(values = c("purple", "cornflowerblue", "FF0000"))

library(viridis)

p + scale_fill_viridis(discrete = TRUE, option = "plasma")

p + theme_dark() +
  theme(axis.text.x =element_text(angle = 90, hjust = 1))

library(ggthemes)

p + theme_stata()

final <- p + theme_minimal() +
  theme(axis.text.x =element_text(angle = 90, hjust = 1), 
        panel.border = element_rect(fill = NA), 
        strip.text.x = element_text(face = "bold", size=16), 
        plot.title = element_text(hjust = 0.5, size = 18), 
        axis.ticks.y = element_line(), 
        panel.grid.minor = element_line(), 
        panel.grid.major = element_line(color = "black"), 
        panel.background = element_rect(fill = "grey"))

ggsave(plot = final, filename = "final_plot.pdf", path = "img", device = "pdf", width = 150, height = 150, units = "mm", scale = 2)

library(ggpubr)

hist <- ggplot(fdat, aes(OTUs, fill=Country, alpha = 0.3)) +
  geom_histogram(binwidth = 50, position = "dodge") +
  xlim(0,1000) +
  ylim(0, 150) +
  geom_rug() +
  guides(alpha = FALSE) +
  theme(legend.justification = c(1,1), legend.position = c(1,1), legend.background = element_blank())

dot <- ggplot(ndat, aes(TS, CODt)) + geom_point() +
  scale_y_log10() +
  facet_grid(~Country) + 
  stat_smooth(method = lm)

ggarrange(dot, hist, labels = c("A", "B"), ncol = 2, nrow =1)

boxplot <- ggplot(dat, aes(Taxa, OTUs)) +
  geom_boxplot() +
  theme(axis.text.x =element_text(angle = 90, hjust = 1)) + scale_y_log10()

ggarrange(b, ggarrange(hist, dot, nrow=2, 
          labels = c("B", "C")), ncol =2, labels = "A")




ndat <- read_csv("data/ndat.csv")
jdat <- read_csv("data/jdat.csv")

anti_join(jdat, ndat, by = c("Samples" = "Site"))

dim(joindat)
str(joindat)








