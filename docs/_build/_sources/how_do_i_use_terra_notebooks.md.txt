# How do I use Terra Notebooks?
## Do I even need to use Terra Notebooks?

If you are able to run analyses on your laptop, it is probably easier to do that then use the Terra Notebooks. The main reason to use these notebooks, is that you can use more RAM and CPUs that you can on your laptop.

If your laptop has > 8GB RAM an >= 4 core CPU and > 100GB storage, you can probably work with datasets up to 20-30 thousand cells. Otherwise, you may need to create a Terra compute environment.

## What is a Terra compute environment?

**Simplified, a Terra compute environment makes a computer in the cloud with user specified amounts of RAM, CPUs, and Storage.** 

Note that this environment is separate to the "workspace bucket" where you see files in the terra data tab

More technically, a compute environment creates two things: a google "persistent disk" that stores your data and installed packages and a google "compute node" that has working memory and runs the Jupyter server. The reason for this separation is that you can start and stop the cluster (play/pause buttons) and that will only affect the compute node. Your running code will be stopped, but all of your installed packages and copied files will stay safe on the persistent disk. 

Jupyter Notebooks run in the Terra compute environment are semi-integrated to your workspace, and intended for downstream analysis using Python or R. Jupyter itself acts like it would on your desktop, so see [Jupyter's help docs](https://jupyter.readthedocs.io/en/latest/) for more info on using its interface. 

When you want to start fresh, you can delete the cluster (trashcan button) which will kill both the persistent disk and the compute node (deleting any installed packages, and saved files in the compute environment) 

Each user gets to create 1 notebook cluster per billing project they have access to. (In our case that is 1 cluster per person). 

## Creating a basic Seurat v3 environment

To get started with single-cell analysis, click on the cog button in the upper right corner of your workspace

1. select "custom environment" in the Environment field 
2. paste `shaleklab/terra-seurat-env:release-v1.0` into the "container image" field. This custom environment already has Seurat v3 installed
3. Choose how much RAM, CPUs, or Storage you need. To start just select "(Default) moderate compute power"
4. click create button

**Note: Updating any of these values will require a complete teardown and recreation of the environment. Make sure to backup any required files saved in the compute environment to the workspace bucket before doing so.** 

## Moving Data 

The notebook's persistent disk currently is not directly connected to you workspace bucket, but it is setup to allow faster transfer of files to your bucket than you would see from your laptop. 

`gsutil` is installed and configured to allow copying and syncing of files between the compute environment and workspace bucket. The easiest way to access `gsutil` is from the Jupyter notebook's system commands. If you are in a Python kernel prefix bash commands with `!` e.g. 

`!gsutil -m cp -r <WORKSPACE_BUCKET>/<your_folder> ~/local/path/in/compute/environment`

Or in an R kernel using the `system()` function e.g.

`system("gsutil -m cp -r <WORKSPACE_BUCKET>/<your_folder> ~/local/path/in/compute/environment", intern=TRUE)`

the `intern=TRUE` argument allows Jupyter to show the output in the notebook.

Find your workspace bucket hash "name of the bucket", in the right bar of the dashboard tab. 

`gsutil` also has an [`rsync` command](https://cloud.google.com/storage/docs/gsutil/commands/rsync) which is useful for syncing your analysis folder to your workspace bucket. 

## Installing Extra Packages

`pip` and `devtools` are installed by default and work pretty well. From within any notebook you can install extra packages 

```
# Python3
!pip install scanpy
```

```
# R
install.packages("package")
devtools::install_github("user@repository")
biocManager::install("bioPackage")
```

There is an example setup notebook on how to install packages in the [ShalekLab-Library](https://app.terra.bio/#workspaces/shalek-lab-firecloud/ShalekLab-Library/notebooks/launch/AnalysisSetup.ipynb/?read-only=true). You probably don't need to install all packages in the notebook.

Please copy the notebook to your workspace before editing, so that others still have access to resource! Thanks! (each cell contains the dependencies for the last package installed in the cell)

## Installing Extra Packages with root permissions

You do not have sudo permissions in the notebooks, so you will need to install to user directory. If for some reason you absolutely need sudo permissions, there is the option to edit the DockerFile and create a new custom docker image to start from

See: 

* [Terra's instructions on creating custom docker images](https://github.com/databiosphere/terra-docker#terra-base-images) 
* [Example custom image by BenD](https://github.com/ShalekLab/terra-seurat-env)
* [Example Docker hub configuration for custom image](https://hub.docker.com/repository/docker/shaleklab/terra-seurat-env)
