# gcam-useful-tricks

This repository aims to gather different information regarding GCAM management. If you think that the community could benefit from further information or that some information must be updated, feel free to do it yourself or let us know so we can include it!! :)

<!-- ------------------------>

<!-- ------------------------>

## <a name="contents"></a>Contents

<!-- ------------------------>

<!-- ------------------------>

  - [How to run GCAM in debug mode](#how-to-run-gcam-in-debug-mode)
    - [Description](#debug-description)
    - [Guide](#debug-guide)
  - [How to run GCAM saving only some queries](#how-to-run-gcam-saving-only-some-queries)
    - [Description](#savingQueries-description)
    - [Guide](#savingQueries-guide)
  - [How to run GCAM in parallel in a standard computer](#how-to-run-gcam-in-parallel-in-a-standard-computer)
    - [Description](#parallel-description)
    - [Guide](#parallel-guide)

<!-- ------------------------>

<!-- ------------------------>

## <a name="how-to-run-gcam-in-debug-mode"></a>How to run GCAM in debug mode

<!-- ------------------------>

<!-- ------------------------>

[Back to Contents](#contents)

### <a name="debug-description"></a>Description

With this procedure you can run GCAM in debug mode. GCAM will stop when finding an `ERROR` and it will prompt the c++ line that launched the exception.

### <a name="debug-guide"></a>Guide

To run GCAM in debug mode, follow the next steps:

1. Open VS project file: `cvs\objects\build\vc10\objects.vcxproj`
2. Right click GCAM project (objects-main) and click *Properties*
3. under +Configuration Properties*, select *Debugging* and edit the *Working Directory* variable value to the path to your `exe` folder. Click `apply`.
4. From the menu bar, click *Debug* > *Start debugging*

Notice: you may get a Java curveball that says something like:
```
"Exception thrown at 0x000002543918095C in gcam.exe: 0xC0000005: Access violation reading location 0x0000000000000000."
```
To solve it, 
- Take note of the number after *gcam.exe* ("0xC0000005" in this case)
- In the error window, click *Open Exception Settings*, expand Win32 Exceptions, find the number from the error message ("0xC0000005" in this case), and uncheck the exception associated with this number
- Relaunch the debug run (point 4)


<!-- ------------------------>

<!-- ------------------------>

## <a name="how-to-run-gcam-saving-only-some-queries"></a>How to run GCAM saving only some queries

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

## <a name="how-to-run-gcam-in-parallel-in-a-standard-computer"></a>How to run GCAM in parallel in a standard computer

<!-- ------------------------>

<!-- ------------------------>

[Back to Contents](#contents)

### <a name="parallel-description"></a>Description

With this procedure you can run GCAM scenarios in parallel in any Windows computer. For other operating systems, the scripts would need to be addapted. Notice that it is advisable to use an external server, since the whole run might take some hours (depending on how many scenarios are running), and in this way you can turn off your computer. This procedure can be adapted to run in parallel any script you like.

### <a name="parallel-guide"></a>Guide

To use this running mode, follow the next steps. All necessary files are available in this repo in the folder `Run_parallel`:



1. Download Cygwin: https://www.cygwin.com/
2. Create a mapping such `scenario_db_mapping.csv`. The first column must contain the scenario name and the second column must contain the database name where you want to store your GCAM output. It is advisable to consider multiple databases since only runs that will be stored in different databases can be run in parallel. Store the file as `exe/scenario_db_mapping.csv`.
3. There are two possibilities regarding the configuration file:
   
   	a. Create manually all configuration files you need.

	  b. Create automatically the required configuration files.

      In case you follow the first option, you will need to adapt a little bit the scripts defined in the following steps. To follow the second procedure, create a *base* configuration file, such as `configuration_parallel.xml` and store it as `exe/configuration_parallel.xml`. Notice that you can add as many xmls link to as you want.

4. Modify `run-gcam-shell.sh`, `run-gcam-shell-2.sh`, `run-r-scripts.bat` and `create_prj.R` to meet your requirements. Copy them in your `exe` folder. They will be called in this order. 
5. Copy the file `run-gcam-specifyConfig.bat` in your `exe` folder.
6. Open your `Cygwin` (it will open a terminal) and go to your `GCAM/exe` folder.
   ```
   cd path/to/your/GCAM/exe/folder
   ``` 
7. Run the following to give permissions to the script `re-write-chmod.sh`
   ```
   awk '{ sub("\r$", ""); print }' re-write-chmod.sh > tmp.sh
   mv tmp.sh re-write-chmod.sh
   chmod +x re-write-chmod.sh
   ```
8. Run the following to give permissions to the rest of the scripts and run GCAM in parallel mode.
   ```
   ./re-write-chmod.sh
   ./run-gcam-shell.sh
   ```
   Every time you modify any of the files `run-gcam-shell.sh` or `run-gcam-shell-2.sh`, you will need to re-run `re-write-chmod.sh`. This is to re-shape the scripts so that Cygwin can read them.


