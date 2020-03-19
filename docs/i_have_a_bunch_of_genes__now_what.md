# I have a bunch of genes  now what?
Once you get a list of genes from differential expression, you probably want to do two things:
* Figure out what cell types you have in your dataset
* Figure out what those cell types are doing - do they look like other cells of that cell type?

This review compares a few methods for automated cluster assignment: https://f1000research.com/articles/8-296/v1

And these describe methods that are useful if you have a training set (as in some dataset of cells with scRNA-seq gene expression data that are already labeled with cell types and you think your data may be similar to) - [Zhao et al Briefings in Bioinformatics 2019](https://academic.oup.com/bib/advance-article/doi/10.1093/bib/bbz096/5593804) and [Abdelaal et al Genome Biology 2019](https://genomebiology.biomedcentral.com/articles/10.1186/s13059-019-1795-z). There was a subgroup presentation on automatic cell type labeling which can be found on these [Google slides](https://docs.google.com/presentation/d/1luYSOhmiXHJFbpr265jJr5agOgR4x2GHO3TBBisCdjw/edit?usp=sharing) and in the Dropbox. 

Gene set enrichment analysis (GSEA) is one option. Check out http://software.broadinstitute.org/gsea/msigdb/annotate.jsp for a non-ranked version of GSEA - that is a good first pass.

Another thing Alex asks for a lot is IPA - this is a paid software with a proprietary algorithm (so Carly says this is not a good thing to use since we don’t know exactly how it works). Qiagen puts out some training materials online that can be helpful in learning IPA. If you want to use it, the Broad has a license which you can get by looking at this: https://broad.service-now.com/sp?id=kb_article&sys_id=c8fa6e1a13a7e640df1955912244b0d9 .

A major difference between GSEA and IPA is that the lists in GSEA were generated experimentally (but may not be from the exact cell type you care about) and the IPA lists are curated.

Mostly, the way I handle giant gene lists is to google your genes one by one. They (older grad students) say you will eventually start remembering the names of genes, but that hasn’t really happened for me yet. Try googling the gene name with the cell type or the disease/condition you are studying to come up with its relevance in the situation you are interested in - a lot of times, websites like Gene Cards are really vague or a gene doesn’t have a well-described function but has been linked to some disease. 

Also Jose, Carly, and Sam K (and others!) can usually just look at a list of genes and tell you exactly what is going on.

Alex will ask you to "score" genes based on existing gene lists - to find these gene lists you can search around on msigDB or in the literature, but your best bet again is to just ask on slack. People know a lot of stuff!

R tool for GO (gene ontology) annotation - https://bioconductor.org/packages/release/bioc/html/piano.html 


## Databases of gene lists and cell types:

http://mousebrain.org/ can be treated as a ‘cell type wiki’

https://panglaodb.se/ has extensive scRNA-seq data searchable by celltype and other metadata. You can see what genes other people saw as highly expressed in cell types you think you might have in your data.

https://singlecell.broadinstitute.org/single_cell Single Cell Portal has a 'gene search' function, so if you have some marker genes, you could search those genes on there and see which cell types have those genes

