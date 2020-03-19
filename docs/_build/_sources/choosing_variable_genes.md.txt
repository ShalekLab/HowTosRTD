# Choosing variable genes
If the goal of your analysis is to find ways that groups of cells differ, you only care about genes that are not the same in every cell.


### Choosing variable genes is an iterative process
A really important part of the process of choosing variable genes (and the rest of the steps in this document) is that it is an iterative process. Your goal is to find biology in your data, so you will start by looking at the big axes of variation - sometimes cell type or treatment group - then you will look more carefully at other forms of variation. This means that as you ask different questions and consider different subsets of cells you will look at different sets of variable genes. As an example, a gene that is not expressed in T Cells but is expressed highly in epithelial cells may be highly variable (ranging from 0 in some cells to high expression in others) and of much interest at the first step of your analysis - when you are trying to separate T cells from epithelial cells. When you are trying to figure out which T Cell subsets you have in your data, this same gene (which is not expressed at all in T cells) will not be informative to your analysis at all. The genes that are most informative to the variance in this subset of cells could also be genes that were not included in the analysis targeted at clustering cell types. This is because you are likely thresholding on some arbitrary value when choosing which genes to include in that analysis, and these genes that vary within one cluster may have variance less than your cutoff.



### If removing genes makes it harder to find some heterogeneity, why remove any at all?
Because this data is so noisy, it is always hard at every step of analysis to differentiate biological signal from noise. If you think about this in the extreme cases - if only one cell is expressing a gene, what information is that gene telling you about that cell in relation to the other cells? Not much except that it might be different from all of the other cells (which is information we could not use in our analysis because one cell is never going to give us enough information to draw biological conclusions) OR that this one gene was randomly detected in that one cell through some error. What if all the cells were expressing a gene at about the same level and one cell was expressing it higher or lower? Would you be convinced of any biological conclusions based on that one cell? Probably not. Still, if you don’t remove these genes, they will be included in your dimensionality reduction and downstream analysis. In effect, your downstream analysis will be trying to take into account the variance described by these non-convincing genes, unless you tell it that you are not convinced by genes that change so subtley by removing them from the analysis. In general I relate to discomfort in setting thresholds (because why can’t we just make everything nice and bayesian?), but this seems to be currently the state of the art and works well in practice. (maybe if someone figured out how to do inference efficiently in zero inflated negative binomial models more effectively we wouldn’t need to rely on cutoffs!)


### But it looks like Seurat is filtering on dispersion, not variance?
In most single cell pipelines, genes are filtered on [dispersion](https://www.google.com/url?q=https://en.wikipedia.org/wiki/Index_of_dispersion&sa=D&ust=1539979813150000). When you ask Seurat to filter variable genes, it will show you a plot of dispersion vs mean. The dispersion is the variance divided by the mean. The reason this is used here is that genes with a higher mean expression will likely have a higher variance and vise versa. By scaling the variance by the mean, you avoid filtering out just the lowly expressed genes.

One interesting thing to notice here is that single cell RNA-seq data is overdispersed, meaning the dispersion is greater than 1. This has a lot of important modeling implications for this data. Specifically, a convenient distribution for count data, the Poission distribution, assumes that the mean == variance, so the dispersion is 1. This unfortunately makes this distribution a poor fit for modeling this data. In its place people use the negative binomial distribution which does a better job of modeling overdispersed counts.


### Why does Seurat include a threshold for max mean and max dispersion?
Idk man, I just use these to remove clear outliers. I’m sure there is a good explanation somewhere for this...


