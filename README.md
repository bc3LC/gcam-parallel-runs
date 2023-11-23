# gcam-useful-tricks

ATTENTION: WORK IN PROGRESS



<!-- ------------------------>

<!-- ------------------------>

## <a name="contents"></a>Contents

<!-- ------------------------>

<!-- ------------------------>

-   [Contents](#contents)

-   [How to run GCAM in debug mode](#debug)

-   [How to run GCAM saving only some queries](#savingQueries)

-   [How to run GCAM in parallel in a standard computer](#parallel)

<!-- ------------------------>

<!-- ------------------------>

## <a name="debug"></a>How to run GCAM in debug mode

<!-- ------------------------>

<!-- ------------------------>

[Back to Contents](#contents)

<!-- ------------------------>

<!-- ------------------------>

## <a name="savingQueries"></a>How to run GCAM saving only some queries

<!-- ------------------------>

<!-- ------------------------>

[Back to Contents](#contents)

### <a name="savingQueries-description"></a>Description

With this procedure you can run GCAM saving only the desired queries, which will avoid time and memory space in your computer. The desired queries will be stored as `.csv`.

### <a name="savingQueries-guide"></a>Guide

To use this running mode, follow the next steps. All necessary files are available in this repo in the folder `Save_queries`:

1. Replace the `exe/XMLDBDriver.properties` file for the `XMLDBDriver.properties` file you can find in this repository.
2. Copy the folder `batch_queries` into `exe/batch_queries`. It contains an example of two queries that will be stored. 
3. Create a folder called `exe/DB` to store the results.
4. Simply run `run-gcam.bat` as you usually do.

Notice that to change the desired queries to save, you can add/modify files following the examples `NCEM` and `CLUC` available in the `batch_queries` folder. You will need to include them in the `batch_queries/xmldb_batch.xml` file.

<!-- ------------------------>

<!-- ------------------------>

## <a name="parallel"></a>How to run GCAM in parallel in a standard computer

<!-- ------------------------>

<!-- ------------------------>

[Back to Contents](#contents)


