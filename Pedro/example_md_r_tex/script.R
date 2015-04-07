# We use cork production data from package `agridat`

library(agridat)
data("box.cork")

summary(box.cork)

# We melt from 4 columns into a single column

library(reshape2)

cork.melted <- melt(box.cork, id.vars = "tree", variable.name = "trunk.side", value.name = "cork.cg")

# we do exploratory plotting
# 
library(ggplot2)

fig.cork <- ggplot(data = cork.melted, aes(x = trunk.side, y = cork.cg)) + geom_point()
fig.cork
fig.cork + geom_boxplot(fill = NA)
fig.cork + geom_boxplot(fill = NA) + scale_y_log10()

fig.cork + geom_violin(fill = NA)
fig.cork + geom_violin(fill = NA) + scale_y_log10()

fig.cork1 <- ggplot(data = cork.melted, aes(x = cork.cg, colour = trunk.side)) + geom_density() + xlim(0, NA)

fig.cork2 <- ggplot(data = cork.melted, aes(x = cork.cg, fill = trunk.side)) + 
  geom_histogram(binwidth = 10) + facet_wrap(~trunk.side, ncol = 2)

# we fit a linear model, calculate and ANOVA table
# and check diagnosis plots
# 
cork.fit <- lm(log10(cork.cg) ~ trunk.side + tree, data = cork.melted)

anova(cork.fit)
plot(cork.fit)


