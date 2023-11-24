#!/bin/bash

## DESCRIPTION: this file is run by run-gcam-shell.sh with a parameter, that corresponds to the database name.
## The idea is to run all scenarios whose output will be stored in this same database. Therefore, we loop through
## all the items in the scenario_db_mapping file and check row by row if the specified database corresponds to 
## the database name recieved as a parameter when launching this file. If so, we run the scenario.

## To run the scenarios, we copy the basic configuration file (configuration_parallel) but modify the database name,
## scenario name, and specific xmls required for each scenario. You can add more parameters to be modified by adding
## them in the same line 36. Finally, we run GCAM. 

## Once all runs stored in the considered database are performed, we launch an R script to start creating the project
## with the script run-r-scripts.bat

# Read the CSV file and database name
csvfile=csvfile=scenario_db_mapping.csv
database=$1

#### RUN GCAM
# Read the CSV file (assuming col1 = scenario and col2 = database are the first and second columns)
while IFS=, read -r scenario col2; do
    echo "database = $col2"
    # Trim col2 to remove leading/trailing spaces
    trimmed_col2=$(echo "$col2" | tr -d '[:space:]' | tr -d '"')
    trimmed_database=$(echo "$database" | tr -d '[:space:]' | tr -d '"')
    # Check if col2 matches the database
    if [ "$trimmed_col2" = "$trimmed_database" ]; then
        trimmed_scenario=$(echo "$scenario" | tr -d '[:space:]' | tr -d '"')
        trimmed_scenario_xml=$(echo "$scenario" | tr -d '[:space:]' | tr -d '"' | sed 's/d/\./g')
        echo "Consider database = $trimmed_database and scenario = $trimmed_scenario"

        # Set the configuration file
        config_file_base=configuration_parallel.xml
        config_file_loop=configuration_$trimmed_database.xml

        sed -e "s/XXXDBXXX/$trimmed_database/g" -e "s/XXXSCENXXX/$trimmed_scenario/g" -e "s/XXXSCENXMLXXX/$trimmed_scenario_xml/g" $config_file_base > $config_file_loop

        # Run gcam and redirect the output to the logFile
        ./run-gcam-specifyConfig.bat $config_file_loop
    fi
done < $csvfile
#### END RUN GCAM

#### RUN R (PRJ CREATION)
# Launch the R script to generate the project
trimmed_database=$(echo "$database" | tr -d '[:space:]' | tr -d '"')
./run-r-scripts.bat $trimmed_database
#### END R (PRJ CREATION)
