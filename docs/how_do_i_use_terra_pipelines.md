# How do I use Terra Pipelines?
## Basics

Data processing tasks (demultiplexing, alignment, other tasks that don't require intense interaction) are performed by using the workflows in the tools tab of your workspace. These workflows are written in [WDL](https://software.broadinstitute.org/wdl/). 

The tools tab in a new workspace is empty because you will need to import the tools you want. See the [ShalekLab-Library workspace](https://app.terra.bio/#workspaces/shalek-lab-firecloud/ShalekLab-Library/tools) tools tab for some standard workflows the lab uses. Press on the vertical ellipsis button on the workflow to copy it to your workspace. 

If you can't find the workflow you need in the the ShalekLab-Library, you can also import external workflows. From the tools tab in your workspace press the *Find a Tool* button. You will be given the option to import from [Dockstore](https://dockstore.org/) or the [Broad Methods Repository](https://portal.firecloud.org/#methods). The Broad methods repository is more established, but Terra is moving toward encouraging  use of Dockstore. In either case they have a search bar to search by name of workflow. Once you find the Workflow you would like to use. Press the **export to workspace** or **add to terra** button on the right side of the page. From the Broad Methods Repository, a pop up will appear asking if you want to use a configuration file. Most methods don't have configurations (default input json file), so press the **use blank configuration** button. 

Once your tool is imported you should see a new tile in the Tools tab of your workspace. Pressing the tools title opens up the tool's configuration page. There are 4 buttons main sections to this page:

1. Script, This is how you can look at the actual workflow and see what the input defaults are. If you have questions about what the workflow is doing, this is a good first place to look
2. Inputs, This is where you can enter input arguments to the workflow.
3. Outputs, this is not always used but is where you can see where the outputs of the workflow are stored in the Data Model (tables setion in the left bar of the Data tab).
4. Run Analysis, the submit button

## Data Model

The data model is mainly used for running batch jobs. e.g. running the same workflow $n$ times with different inputs. The data model is a `.tsv` file where each row is a sample and each column is the arguments for this sample for this workflow. 

The column names are the first row and one of the columns (usually "sample_id") must have set as the entity so that Tarra can keep track of the samples accross the data model. Set the entity by naming the column `entity:sample_id`. 

This data model can be very useful because links to the outputs of the workflow can be written back to the file, making it easier to keep track of your important files. 

When running a batch job in terra, to set the inputs to the columns of your sample file use `this.column_name` 

## Troubleshooting

It is common for the workflow to not work the first time you try to use it. This is usually because you have not completely figured out what to enter as the inputs. This happens to all of us. All the time. It is really frustrating, but there are some things to try. 

1. look at the script section of the tool. there is a `workflow <name> {…}` section in there and the first part of it is just listing all the arguments, their data types, and there default values if it is an optional argument. Developers will also sometimes put hints next to the argument to help figure out what to enter.

2. Make sure all your file names are `gs://` urls and enclosed by `"` marks. 

3. Check the error logs. In the Job History tab you will be able to check the status of your submission, clicking the **view** link will take you to the task status page and in the top right tile are some buttons to link to the stdout, stderr files and the execution directory. If you don't see anything in the files, also check the execution directory. Some workflows output to non-standard log files.

   Look for common issues:

   1.  "file does not exist" are your input file names correct?
   2. "Out of memory" see if you can adjust to more memory via inputs
   3. "Out of disk space" see if you can adjust to more memory via inputs
   4. A lot of workflows use preemptibles, these are cheaper cloud computers that google can shut down before they complete. check for an `attempt2` folder in the execution directory. Usually these errors can be solved by resubmitting with no changes. You can also see if you can increase a "preemptible" argument (number of attempts before failing).

4. If someone else is able to successfully use the tool, see how their inputs are configured.

