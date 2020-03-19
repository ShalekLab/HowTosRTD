# Network Inference
One of the really cool potential applications of scRNA-seq is building gene regulatory networks (GRNs) more easily. Usually, in order to build a GRN with bulk RNA-seq or other assays you need data from many conditions with different perturbations. As stated in previous sections, it is said that single cells in a scRNA-seq data set can be thought of each as small micro-perturbations. Therefore, there is some hope that these can be used to build a gene regulatory network. Unfortunately, it is not clear that it is that simple. Since these cells still represent a snapshot of the cells in the system, it is not clear how one would know what upstream driver is causing each perturbation. Without this information, is is not possible to build a network that describes which gene causes the expression of another gene. In order to do this you need a time course, perturbation studies, or multi-omics information. 

These reviews: https://academic.oup.com/bfg/article/17/4/246/4803107 , https://link.springer.com/protocol/10.1007%2F978-1-4939-8882-2_10 describe some approaches.

The method SCENIC is an approach to scRNA-seq GRN annotation. They apply it in this paper (https://doi.org/10.1016/j.cell.2018.05.057) and find some interesting results. Sam Allon said he had a really hard time installing this.

But this review: https://bmcbioinformatics.biomedcentral.com/track/pdf/10.1186/s12859-018-2217-z says these methods are really not great for scRNA-seq data. 
