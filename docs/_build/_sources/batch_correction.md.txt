# Batch Correction
What if you have data from multiple batches? It could be different arrays, different patients, or even different sequencing technologies. Unfortunately, these data sometimes separate based on batch in dimensionality reduced space. The first thing you should think about here is - do you really think these differences are not biological? If you are convinced that they are not and you need to consider all of the cells together then batch correction is for you.

The simplest approach to this is to just regress out the sources of variation - for instance if you think that your differences are driven by number of UMI per cell, you could regress that out. Same goes for mitochondrial genes, as is described in the Seurat tutorial. Seurat and scanpy both have functions called ‘regress_out’ which do this.

Some batch correction methods are as follows:

**CCA in Seurat** - Canonical Correlation Analysis - this requires that you expect most of the types of cells in your data sets to exist in all data sets. _The following is written about an old version of CCA, so I am not sure if it is still valid_ They call this ‘alignment’ https://satijalab.org/seurat/Seurat_AlignmentTutorial.html 
Side note: the ‘FindConservedMarkers’ function associated with this batch correction is really sketchy. It simply does a p-value comparison between the marker genes in the groups you are comparing (using a package whose own documentation discorages users from doing p-value comparisons when effect sizes are available, which they are here). Not only does it do a p-value comparison, but it reports the ‘consensus p-value’ as the minimum p-value among the groups in the comparisons. In theory, this is a legitimate p-value comparison method described in meta-analysis literature, but I have a problem with this for several reasons. One is that if (and this happened to me) you are comparing two groups of cells that are simply different and you shouldn’t be doing batch correction on in the first place, you will be get from this method a list of genes that are ‘conserved’ in their differences but could be totally different in their significance or effect size. This meant in this bad analysis that a gene with p-value ~ 1 in one batch and p-value ~ .05 in the other batch was considered highly conserved between the two batches. While some of the onus is on the user to not be doing batch correction on data that is so dissimilar that the differences are biological and not batch specific, this degree of confidence in a wrong solution is concerning, and several of the methods listed below this simply returned no conserved markers when ran on this data set. The other problem I have with this approach is that it seems that is marketed as an approach that uses a mathematically reasonable batch correction technique (CCA) to transform the data then looks for markers in this transformed data. This is not what is going on, it is simply doing a meta-analysis of the two batches.
These issues with this approach are not kept secret at all by the authors, they are clearly spelled out in the methods of the paper, but it is important to look carefully at these results as this method might not be doing what you would expect!


**Seurat v3** has a new version of batch correction described [here](https://satijalab.org/seurat/v3.0/immune_alignment.html). It is supposed to be much better than CCA and allows >2 datasets with or without many overlapping cells.

**MNN from the Marioni lab** - Mutual Nearest Neighbors https://www.nature.com/articles/nbt.4091 This is implemented in scanpy as the mnn_correct method

**scVI** from the Yosef lab does a form of batch correction using bayesian deep generative models as is described in this blog post http://www.nxn.se/valent/2018/4/20/count-based-autoencoders-and-the-future-for-scrna-seq-analysis. Sarah has tried this method out and thinks it is really great. It also allows you to sample from the posterior of the expression values allowing you to place a measure of uncertainty on any downstream analysis. https://niryosef.wordpress.com/tools/tools-scvi/

**Scanorama** is a method that stitches together single cell datasets using methods similar to those used for stitching panoramas - http://cb.csail.mit.edu/cb/scanorama/. This method is easily run on scanpy anndata objects and can also be called from R as described in the README on the github. It is very easy to install using pip. This method is similar to the Seurat V3 batch correction method and was conceived at the same time. 

**Scmap** projects data between experiments - http://bioconductor.org/packages/release/bioc/html/scmap.html 

**scMerge** https://github.com/SydneyBioX/scMerge is another integration method that is implemented in R

**BBKNN** - claims to be the fastest around and is implemented in scanpy
https://www.biorxiv.org/content/biorxiv/early/2018/08/21/397042.full.pdf?%3Fcollection= 

**SAUCIE** - on a skim, this looks sketchy, but have not read it carefully or tried it https://www.biorxiv.org/content/biorxiv/early/2018/08/27/237065.1.full.pdf?%3Fcollection= 


## Which should I use?

Sarah did a comp subgroup on this called - Comp_subgroup_journal_club_5.22.18.pptx. It’s in the Talks & Posters/Journal Club dropbox folder. This contains tests for MNN, CCA, and scVI.

Shalek thinks the underlying principles behind CCA are more principled for single cell- the idea that correlation structure is conserved between batches makes more sense than looking at overlapping nearest neighbors. Since he said that, CCA has sort of fallen out of favor, so we should probably ask him again what he thinks we should use.

A review on how to assess batch correction methods - https://doi.org/10.1101/200345 

Another method is to develop your own GLM (generalized linear model) for differential expression that blocks for batch.
