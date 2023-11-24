#### PREPROCESS ================================================================
# ==============================================================================

### setwd to file location, set library and charge specific pkgs === #####
setwd('C:\\...path-to-your-script...')
.libPaths('C:\\...path-to-your-R-library-if-you-want-to-specify-it...\\R\\win-library')
library(rgcam)
library(dplyr)
library(tidyr)
library(ggplot2)
library(rfasst)
library(data.table)

### Read arguments (in this example, the database name) === #####
args = commandArgs(trailingOnly=TRUE)
db_it = args[1]
print(db_it)

### Charge the scenario_db_mapping file to create the project containing all the runs
### stored in the particular database
db_scen_mapping <- read.csv("scenario_db_mapping.csv"), header = TRUE) %>%
    rename_all(~c('scenarios','database')) %>%
    as.data.table()

list_scen = list()
for(tt in unique(db_scen_mapping$database)) {
    tmp_list <<- db_scen_mapping$scenarios[db_scen_mapping$database == tt]
    list_scen[[paste0('list_scen_',tt)]] = tmp_list
}

### Function to create the project. The project name and the scenario names should be specified
create_prj = function(prj_name, prj_desired_scen, onlyFoodConsumption = FALSE) {
  db_path = '...path-to-your-db...'
  query_path = '...path-to-your-queries...'
  queries = 'queries_beh.xml' # queries file name

  if (!file.exists(prj_name)) {
    print('create prj')
    for (sc in prj_desired_scen) {
      print(sc)
      db_name = find_db_name(sc)

      ## create prj
      conn <- rgcam::localDBConn(db_path, db_name)
      prj <- rgcam::addScenario(conn, prj_name, sc,
                                 paste0(query_path, queries),
                                 clobber = FALSE)
    }

    saveProject(prj, file = prj_name)
  }

  return(prj)
}


### Specify the project name, the considered scenarios, and call the function to create the project!! :)
prj_name = paste0(db_it,'.dat')
list_scen_it = list_scen[[paste0('list_scen_',db_it)]]
prj = create_prj(prj_name,list_scen_it)
