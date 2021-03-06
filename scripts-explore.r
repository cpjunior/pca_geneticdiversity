#
# Install Packages
pacotes <- c("plotly", "tidyverse", "readxl", "factoextra", "pca3d",
             "FactoMineR")

if (sum(as.numeric(!pacotes %in% installed.packages())) != 0) {
  instalador <- pacotes[!pacotes %in% installed.packages()]
  for (i in 1:length(instalador)) {
    install.packages(instalador, dependencies = T)
    break
  }
  sapply(pacotes, require, character = T)
} else {
  sapply(pacotes, require, character = T)
}

# Workspace Configs #
options(ggrepel.max.overlaps = 2000) 
# import dataset #
df_genes <- read.csv("genetic_dataset.csv", header = T, sep = ",")
 view(df_genes)

# sacale #
df_scaled <- scale(df_genes[, -1:-2], center = T)
df_scaled

# spectral decomposition #
pca1 <- princomp(df_scaled)

# visualization #
pca1
summary(pca1)
biplot(pca1)
pca1$scores

# singular decomposition #
pca2 <- prcomp(df_scaled)

# visualization #
pca2
pca2$x
summary(pca2)
biplot(pca2)

# main data #
pca1$scores == pca2$x

# main visualization #
fviz_pca(pca2)
fviz_screeplot(pca2)

# 3d visualization #
pca3d(pca2)
pca3d(pca2, show.labels = TRUE, fancy = TRUE)

# pca svd #
fpca <- PCA(df_scaled, ncp=18)
fpca
fpca$eig
fpca$ind$coord
fpca$ind$cos2
fpca$var$contrib

# plot #
fviz_pca(fpca)
fviz_pca_biplot(fpca, repel=TRUE)
fviz_pca_biplot(fpca, repel=TRUE, col.ind="cos2", cos.var="red")
