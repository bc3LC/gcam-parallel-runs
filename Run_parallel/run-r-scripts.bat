@echo off

@REM DESCRIPTION: this file will launch an R script and is called by run-gcam-shell-2.sh. The idea is to use this
@REM script to generate the GCAM project. To do so, we point at the computer's R program (R.exe file) and specify the R script we want to launch. In
@REM this example, we also pass the database name as an argument to this script, but you can pass more arguments 
@REM if necessary.

@REM The output will be stored in a log file named log_R_'database_name'.log file

setlocal enabledelayedexpansion

set database=%1

"C:\Program Files\R\R-4.1.0\bin\R.exe" R CMD BATCH --vanilla "--args %database%" complete-path-to-your-R-script\create_prj.R log_R_%database%.log