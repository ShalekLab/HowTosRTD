# Other dimensionality reduction
Since PCA doesn’t seem to capture the full variability of single cell data in just two dimensions, people usually run additional dimensionality reduction methods on these principal components to allow for easier viewing of the data. The reason we want to look at the data is to visualize the distribution of gene expression over your data - you can color a dimensionality reduction plot based on expression of a gene. The goal of this plot would be for the clusters of cells we find via clustering in PC space (using more than the first two PC’s usually) to appear grouped in the dimensionality reduced space allowing us to quickly assess which clusters of cells are expressing which genes.

Most dimensionality reduction is really just for visualization though, and as will be described below, should not be used to draw concrete conclusions about your data.


This is a great review on matrix factorization in genomics https://doi.org/10.1016/j.tig.2018.07.003 - matrix factorization includes PCA, ICA, and NMF, and it is great to understand these things since they come up a lot as underlying parts of other methods!

#tSNE

This is one of the most common dimensionality reduction/visualization methods used in single cell data. It originated with [this paper in 2008](http://www.jmlr.org/papers/volume9/vandermaaten08a/vandermaaten08a.pdf),  and Dana Pe’er tried to [patent](https://patents.google.com/patent/US20180046755A1/en) its use for single cell data recently (and [people thought that was really funny](https://twitter.com/mikelove/status/989987028879269890)). People like to remind you that it is relatively meaningless and is just a nice way to look at the data in a number of dimensions that we can actually visualize (2-3), but they still use it a lot. The main thing to remember with tSNE is that it is a stochastic (so running it different times with different starting points will give you different outputs) method that prioritizes short-range distances. This means that if two cells are close together in tSNE space you can be pretty sure that they are similar, but if they are far apart, the distance between them does not tell you how dissimilar they are. 

There are a few parameters to adjust when running tSNE. I am not too familiar with these, but Jay and Carly have a lot of thoughts on them. CAUTION: These tunable hyper-parameters can have a big impact on the output of tSNE, and this is worth keeping in the back of your mind when doing a tSNE analysis. This is illustrated in [this](https://distill.pub/2016/misread-tsne/) amazing interactive resource. I would highly recommend playing with it! Also, Jean Fan has a [blog post](https://jef.works/blog/2018/04/10/interactive-tsne/) with similar interactive features. 


#UMAP

UMAP is a dimensionality reduction method that is compared to tSNE. This [paper](https://doi.org/10.1101/298430) notes that “notably highlighting faster runtime and consistency, meaningful organization of cell clusters and preservation of continuums in UMAP compared to t-SNE.”
This is implemented in Seurat and scanpy.

Recently, UMAP has become more popular.

#Diffusion mapping

Diffusion mapping provides a better view of the continuum of your data. Unlike tSNE, the long range distances can be taken as meaningful in a diffusion map.
https://doi.org/10.1093/bioinformatics/btv325
This is implemented in scanpy.


#Force directed graph

Given an underlying graph representation of the data (ex. kNN graph), a force directed graph visualization will look for an arrangement of the graph that shows an accurate representation of how similar cells are from each other based on their edge weights.
https://github.com/AllonKleinLab/SPRING_dev 
https://kleintools.hms.harvard.edu/tools/spring.html 

#ICA- Independent component analysis

The idea of ICA is to find dimensions in the data that are maximally independent. It is sort of similar to PCA in that it involves a SVD, but it is not as computationally optimized so is not as fast to run. There is a function in Seurat for this method, and this paper (10.1016/j.cell.2018.07.028) claims that it finds more identifiable biological signals on ICA components than PCA does. 
