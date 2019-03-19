## ADFv2 : Read file, validate and perform transformation on the source file data .
Loading file from Blob ,Perform all Validation and perform the transformation

This example is showcase the how file can be read from BLOB storage, Validate based on validatioon critieria mentioned in Meta tables and perform final Transformation .

You can use one of the below option for data Transformation from source file based on your usecases.

# 1. Using ADF v2 and [Data Flow(Preview):](https://docs.microsoft.com/en-us/azure/data-factory/concepts-data-flow-overview) 

In this Option i am using [Lookup](https://docs.microsoft.com/en-us/azure/data-factory/control-flow-lookup-activity) and [if conditon activity](https://docs.microsoft.com/en-us/azure/data-factory/control-flow-if-condition-activity) for validating the validation critiria.

and using Dataflow activity(ADF v2) to perform transformation and write to final csv file

![ADF v2 with Dataflow(Preview)](https://github.com/nikris87/ADFv2FileloadandTransformation/blob/master/ADFv2Dataflow.PNG)


# 2. Using ADF v2 and Stored procedure(Azure SQL DB):
In this Option i am using [Lookup](https://docs.microsoft.com/en-us/azure/data-factory/control-flow-lookup-activity) and [if conditon activity](https://docs.microsoft.com/en-us/azure/data-factory/control-flow-if-condition-activity) for validating the validation critiria.

I am using [Stored proc](https://docs.microsoft.com/en-us/azure/data-factory/transform-data-using-stored-procedure) Activity to perform the transformation. ADF v2 Dataflow will write the incoming source file to SQL DB table and Stored procedure in SQL db will perform the neccessary transformation.

![ADF v2 with stored proc(SQL DB)](https://github.com/nikris87/ADFv2FileloadandTransformation/blob/master/ADFv2Storedproc.PNG)



## Pre requisite :
* Create [Data Factory v2](https://docs.microsoft.com/en-us/azure/data-factory/quickstart-create-data-factory-portal#create-a-data-factory)
* Create [Blob storage](https://docs.microsoft.com/en-us/azure/data-factory/quickstart-create-data-factory-portal#azure-storage-account)   
* Create [SQL DB](https://docs.microsoft.com/en-us/azure/sql-database/sql-database-single-database-get-started) if you are opting the Option 2 design. 


## Adf v2 Sample actvity Explanation :
 Assumptions : 
 * File is already placed in Blob storage .
 * Change the connection string for Blob and SQL DB connection once ARM template is imported to your ADF v2 workspace.
 * Change the filename 
 * File name pareameter has to be changed  in activity level parameter "Filename".
 

