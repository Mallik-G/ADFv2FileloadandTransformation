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
 
 # Importing Sample Pipelines :
 * Import Sample ADF pipeline from my  [Github Repo folder ADFv2Workspace](https://github.com/nikris87/ADFv2FileloadandTransformation/tree/master/ADFv2Workspace) using github integration option in ADF 
 
 * Execute create table script and SP to validate custom validation inserted into thease tables.
 
 * There are 2 example:
 # 1. Pipeline(Using datafloe transformation): Fileimport_validate_Transform_DF  :
 * This Pipeline has a filename paramtere "Filename"
 * Optioanlly you can get file name using Get Metadata activity.
 * In this Sample i a performing 2 validation
   * Validation 1(Lookp activity CheckIfFileLareadyLoaded) : Check if file already loaded 
     This will check log table in SQL DB to varify if file with this name is already processed .If its a new file ,stored procedure will      insert the record to log table .
   * Based on file already processed or not flag from previous Lookup step this will redirect if else condition Accordingly.
     If File already exist True condition part will calls a stored procedure(Stored proc Activitry : WriteException_Fileexist) from          Azure SQL DB and Logs an Exception.

  * If file is new false condition will call another pipeline(Fileimport_validate_Transform_Detail) to validate the second validation .
     * Validation 2 : Check if Configuration exist for this file in File Config :
       This will check config table in SQL DB to verify if file with this name has config .If there is no config SP will return False.
  * If both validation(duplicate file and config exist) passess then if condition will invoke Azure Dataflow    transformation(DataflowTransformationandwritetoCSV).

# 2. Pipeline(Using stored proc transformation): Fileimport_validate_Transform_SP  :

The validation part is similer to above . If all Validation is success pipeline will call another pipline :DF_LoadtoSQLDBandTransformwithSP

This pipeline will load the data to SQL Db using Dataflow . [Schema drift](https://docs.microsoft.com/en-us/azure/data-factory/concepts-data-flow-schema-drift) option will allow to read different  files with variable columns.

Pipeline DF_LoadtoSQLDBandTransformwithSP has 3 activity :
* Dataflowblobtosql : This will write File to SQL table in Azure SQL DB
* SQLDB_Transformation : This will call stored procedure o perform the transformatyion
* DF_SQLDBtoCSV : This will write final result aftre transformation from SQL table to CSV files.


