# Reading in the data (to R)
But here is one little bit on specific code syntax to get you started.


In R choose a function depending on the type of file you have:
```R
genes <- read.table(path_to_genes_file.txt) #for .txt files
metadata <- read.csv(path_to_metadata_file.csv) #for .csv files
```
Look at the documentation for these functions by typing `?read.table` or `?read.csv` into the console. Specifically note parameters that tell R if it should expect a header (basically column names) or an index column (with row names).

Check that you got your row names as expected by typing `rownames(dataframe)` where you replace `dataframe` with the name of the dataframe where you stored your file contents. You can do the same thing with the function `colnames`. You can check the size of your data by typing `length(dataframe)` or by looking at the object’s attributes in the box in the top right corner of RStudio.


Often you will get errors using R objects as inputs to functions that are of a different type than the function expects. To determine the data type the function expects, type `?function_name` where you replace `function_name` with the name of your function and look at the arguments it expects, this will usually describe the data type. To check the type of your data object, use the function `typeof(your_data)`. Then if these do not agree, you can google how to correctly convert between the two data types in R.


Another thing you might need to do is check that the orders of rows or columns in two matrices are the same. For example, you might have a metadata matrix and a cells x genes matrix and you might want to make sure the cells included in the metadata matrix are in the same order as the cells in the expression matrix. To do this, you will subset the dataframe - in R (and python), the process of subsetting a dataframe also changes the order of the axis (rows or columns) on which you are subsetting. The way you subset is with square brackets []. If you have two dataframes - one called ‘genes’ which has rows that are gene names and columns which are cell names, and another called ‘metadata’ which has rows that are cell names and columns that are metadata headers (ex. %transcriptome alignment, etc), you might want to make sure that the cells in the metadata are all contained in the genes matrix. The way you would do that is:

```
metadata <- metadata[colnames(genes), ]
```

This command takes all the rows in the metadata and orders them based on the order of the columns in the genes matrix.

If you wanted to do the opposite and order the genes dataframe based on the metadata cell order:

```
genes <-  genes[ , rownames(metadata)]
```

A few things to be cautious of here are:

If you subset your dataframe with a name that does not exist as a label for that axis of the dataframe (ex. If a cell is not in the genes dataframe but is in the metadata dataframe and you run the genes dataframe subsetting command above) you will get an error indicating that a value is not found BUT if you are doing the opposite - subsetting the genes dataframe on cells in the metadata dataframe where the genes dataframe contains cells that are not in the metadata dataframe, the subsetting will work, but you will lose all the cells in the genes dataframe that are not included in rownames(metadata). If this is the case (and you can usually tell by checking that the number of rows in the metadata and number of columns in the genes are not equal), you will be overwriting the genes dataframe with a new genes dataframe with fewer cells. If you want to keep these cells somewhere else, it is good practice to name the subset genes matrix something else (so type `genes_subset <- genes[ , rownames(metadata)]`)


Now you have some matrices! Time to get analyzing! This is the end of the coding syntax help in this guide - but some concepts to keep in mind here is that most of what you will be doing in single cell analysis is subsetting matrices (or dataframes) and applying transformations to these dataframes. If you are having a problem it is often because you are subsetting incorrectly or you have some invalid value (NaN or infinity) in your matrix that the transformation does not like.


