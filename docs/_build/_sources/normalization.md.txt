# Normalization
Sometimes a single cell gets way more reads than other cells, so it is hard to compare absolute transcript numbers/UMIs. To do this, we normalize. Normalize technically means transform your data so it looks like it was drawn from a normal distribution. That doesn’t really work here because of all the zeros though.


Theoretically, there are two ways to normalize- by genes and by cells. My understanding is that people usually are more interested in the relative expression of each gene in a single cell so they usually normalize by cell. This makes sense in terms of the above comment about number of reads per cell. When visualizing the expression in a heatmap, sometimes you will see cell-normalized expression z-scored per gene. Then you are emphasizing the cells/groups of cells for which the relative expression of some gene is higher or lower than the relative expression in other cells. This can make your clusters look more distinct (and can also help find clusters of genes if you cluster on the z-scored expression).



Some people don’t normalize at all - it is sometimes not legitimate to assume that all cells are the same size/have the same number of transcripts.


Some downstream analyses require normalization because they are statistical methods that expect data to be normally distributed. Raw counts/UMIs are definitely not normally distributed, but scRNA-seq data that is ‘normalized’ is also usually not that normal.


The most common way to normalize is to divide expression in a single cell by the sum of the transcripts/UMIs in that cell then multiply by 10000. Often, after this normalization, people take the log(1+normalized expression) to help visualize the spread in the data. This is what people mean when they say log normalize.


Carly says that life is in log space so you should definitely log your data!


Seurat is the way most people (except Carly?) in the lab normalize their data. Their default method is the log normalization method described above.


An awesome tool developed by Michael Cole exists to visualize the impact of different types of normalization on your data - [SCONE](https://www.google.com/url?q=https://github.com/YosefLab/scone&sa=D&ust=1539979813147000) - Pete loves it, and Michael Cole is great so you should definitely use that.


When normalizing, it is useful to keep in mind that you are imposing the assumption that all cells are about the same size or at least have the same total numbers of transcripts. This is a flawed assumption that the method BISCUIT tries to address.


Data is also often scaled which means giving it a variance of 1 and a mean of 0.


For Smart Seq 2 data, it is popular to first downsample, as you get as an output tpm (transcripts per million), which many downsample to transcripts per 100,000. SCONE is very useful for smart-seq 2 data, I have found, as it can remove quality or batch associated variation if you tell it to do so. Log (1 + …) is also common for smart seq 2 data, however you should check whether your top PCs correlate strongly with quality metrics (such as gene count or % trans_mapped, which can be found in the stats file), as that can often be a consequence of simply log normalising.

### Normalizing pops
