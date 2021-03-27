library(RMariaDB)
library(DBI)
library(dplyr)
library(pool)


print("dbconfig.R")
print(Sys.getenv())
Sys.getenv("PATH")
cn <- dbPool(drv = RMariaDB::MariaDB(), 
                username = Sys.getenv("USERNAME"), 
                password = Sys.getenv("PASSWORD"), 
                host     = Sys.getenv("HOST"), 
                port     = 3306, 
                dbname   = "stinky")

bejing_table <- tbl(cn, "bejing")

glimpse(bejing_table)

# Perform any additional dplyr commands on bejing_table
