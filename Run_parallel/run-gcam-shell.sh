#!/bin/bash

## DESCRIPTION: this file is launched by the user. It launches in parallel a desired number of GCAM runs
## that you can specify in line 39. By default is set to 10. The idea is to check for all different 
## databases in the scenario_db_mapping file, and launch in parallel any scenario that will be stored in
## them using run-gcam-shell-2.sh script. This second script will generate also the GCAM project.

## The console output of each parallel run will be stored in a specific log file, namely logFile_'databaseName'.log

# Read the CSV file and extract unique databases (assuming col1 = scenario and col2 = database are the first 
# and second columns of the CSV)
csvfile=scenario_db_mapping.csv
unique_elements=($(tail -n +2 $csvfile | cut -d ',' -f 2 | sort -u))

# Function to process each unique element in parallel
process_element() {
    element=$(echo "$1" | tr -d '[:space:]')
    echo "Processing element: $element"
    
    # Set the log file
    logFile=$(echo "log_${element}.log" | tr -d '"')

    # Run-gcam script 2
    ./run-gcam-shell-2.sh $element > $logFile
}

# Counter for running processes
count=0

# Loop through unique elements and launch the processing function in parallel
for element in "${unique_elements[@]}"; do
    # Run process_element function in the background
    process_element "$element" &

    # Increment the count of running processes
    ((count++))

    # Wait if the number of running processes exceeds 10.
    if [ $count -ge 10 ]; then
        wait # Wait for all background processes to finish
        count=0 # Reset the counter
    fi
done

# Wait for all background processes to finish
wait

echo "Processing completed for all unique elements."
