# Filtering
### Why threshold

Some cells are crappy- maybe they just didn’t get too many reads, maybe they only got reads for a few genes.

Some genes are just not expressed that highly in your cells. High dimensional data is slower to deal with, and keeping genes that are only expressed in a few cells adds noise to the data. Because of this you should always remove genes that are expressed in no cells at all. People almost always remove genes that are expressed in very few cells (I can’t think of a time when they leave these genes in, but I’m sure someone has done it). This is because these genes provide little information about the data. Genes that are lowly expressed are often not detected, but, as described above, it is difficult to differentiate if these genes are not expressed or just expressed below detectable rates. Someone in the lab (can’t remember who) said to me that they find it hard to believe that a single (or small amount of) transcript of a gene in a cell could ever be enough to really influence cell state. Even if these low counts are representative of real information, they likely have little influence on the phenotype you are trying to observe.


When thresholding, remember to take into account the biology of the system:

* Highly heterogeneous group of cells - more genes will be involved in describing the variation in downstream analysis
* Mostly one cell type - fewer genes will be needed in total
* Large cells will have more RNA, so you should expect more UMIs or read counts to come from those cells than from smaller cells
* Activated/stimulated cells will be expressing more RNA as well as a higher diversity of genes - a more complex library
* If you expect to have some rare cell populations in your data set, be more conservative in gene filtering especially if you are filtering genes out that are expressed in a low fraction of cells.

### What to threshold on

I always threshold cells first then threshold on genes in the remaining cells. This is because if some genes only exist in cells that I consider low quality, I want to remove those genes from my analysis as well. You could say the same in the opposite direction, but because my approaches to cell filtering take into account metadata that is not just number of genes/transcripts while gene filtering only takes into account expression of that gene, I think that filtering on cells first is most useful.


For filtering out low quality cells:

Number of genes, number of UMIs (seq-well) or transcripts (SS2/bulk), %ribosomal RNA, %mitochondrial RNA, % transcriptome mapping, % genome mapping are all parameters you could threshold on.


Second strand synthesis in Seq-Well increases the expected number of genes to ~1000, so your thresholds for these cells should be higher than other technologies.

In SS2 you expect 1000-2000 genes per cell depending on the cell type. Some cells express much fewer genes (because they are small or just not doing much). If your cells are actively dividing, recently stimulated with something, or really big, you expect there to be more different genes. If they are pretty small and are unstimulated you might see fewer genes.


In the Seurat tutorial, they threshold on 200 genes (for 10x data).


Thresholding on % transcriptome mapping and % genome mapping is a way to take into account more technical differences in the quality of that cell’s library. If the percent of genome mapping is much larger than the transcriptome, it is possible that you have mostly genomic reads (and since genomic reads are a superset of transcriptome reads, the transcriptome reads may just be bits of genomic reads that happened to be on transcribed regions). The genome you choose to align to as well as the aligner greatly alter these values, so you need to choose them for each individual dataset. (looking at a histogram of the distributions of these metadata is helpful - just remember to increase the number of bins >10 which is often the default!)


### Examples of bad thresholding (removing biological variation):

Cells are different sizes and produce different amounts of RNA. You can’t use the same gene count threshold for all cell types, and you need to check that you are not cutting out an entire cell type when you threshold your cells. This can be especially problematic with very rare populations.

In situations where you may have multiple samples/arrays for a single project, it may make sense to do you cell/gene filtering twice - on the individual samples if you are doing any analysis on just that data, as well as on the combined raw data from all samples. This is because (and this is exemplified in atlas-style projects like Carly’s monkeys) sometimes a rare cell type has very few cells in each individual sample, but when the samples are combined, it is clear that this cell type is not just noise. If each sample was filtered before combining, you would have lost this cell type.

