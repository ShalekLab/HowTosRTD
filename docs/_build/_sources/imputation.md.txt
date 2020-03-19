# Imputation
People discuss, as a way to compensate for dropout, imputing expected expression values of genes. The idea behind imputation is to use the fact that we assume that genes do not act in isolation - modules of genes move together - to share information across genes and cells. 

Some people (read: Alex Shalek) object to this because it may remove real biological variation.

People in the wider computational sc world also have some issues with imputation, specifically a lack of benchmarks/comparisons https://github.com/theislab/scanpy/issues/189 

Some imputation algorithms: [MAGIC](https://github.com/KrishnaswamyLab/MAGIC), CIDR, [scImpute](https://github.com/Vivianstats/scImpute), [SAVER](https://github.com/mohuangx/SAVER)

Sarah did a comp subgroup on Magic and SAVER - slides are [here](https://docs.google.com/presentation/d/13Lb8-BgCp-5yxz9-O1DLcjVKAef3VcWCKtsID4-3RTM/edit?usp=sharing) as well as in the dropbox at: Talks & Posters/Journal Club/comp_subgroup_JC_7_17_18.pptx

Sarah’s favorite between Magic and SAVER is SAVER because it takes into account the uncertainty of the imputation when estimating gene-gene correlation. Magic does describe a method to compute gene-gene associations in the paper, but the code is not available. Using pearson or spearman correlation to compute gene-gene correlations on the output of Magic imputations gives correlation between all genes of basically 0 or 1 indicating that this method might be over-imputing. 

In general, Sarah thinks that imputation is a useful exercise in thinking about ways to model single cell data but should not necessarily be used to transform data then do downstream analysis. This is because, the zeros do contain some information and replacing them with imputed values without placing some uncertainty on these values loses this information. The insights from the development of imputation methods could allow for the use of these models in conjunction with later analysis as long as the uncertainty is propagated. If you use imputed data for downstream analysis, always check that you can still see whatever biological conclusion you come to in your non-imputed data. Imputation can be used to dig through the noise but should not be assumed to be correct!


This review https://ieeexplore.ieee.org/document/8388285 compares imputation methods.
