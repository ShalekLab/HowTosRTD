# Dropout?
People describe scRNA-seq data as ‘sparse’ and ‘zero-inflated’. This means that there are more zeros in the expression matrix than we think there are actually genes not being expressed at all. The ‘false zeros’ are genes that are actually expressed in a cell but are not picked up in the experiment, but there are also ‘true zeros’ - genes that are not expressed at all. People talk a lot about the best ways to differentiate between true biological sparsity and technical variation.

This paper discusses some of the sources of dropout: https://www.nature.com/articles/nmeth.2967.


Alex references dropout as a combination of biological noise and technical noise. He breaks down biological noise into intrinsic and extrinsic noise as described in this [2000 Elowitz paper](http://www.elowitz.caltech.edu/publications/Noise.pdf).


This guy doesn’t think single-cell RNA seq is zero inflated - http://www.nxn.se/valent/2017/11/16/droplet-scrna-seq-is-not-zero-inflated  - Sam Allon, Jose, and Genshaft had a discussion about this post on slack in the papers chanel on November 17 2017, you can find that discussion by searching ‘zero inflated’ on slack.

This post was peer reviewed and turned into a Nature Biotech article: https://www.nature.com/articles/s41587-019-0379-5

