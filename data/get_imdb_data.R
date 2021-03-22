# get_imdb_data.R
# Downloads IMDB data.
library(io)
library(tidyverse)



## DATA =======================================================================

if (TRUE) {
  csv_files <- list_files("./data", pattern = "csv", full.name = TRUE)
  if (length(csv_files) > 0 ) {
    rm(csv_files)
  } else {
    message("I don't see any files to delete.")
  }
}

# name_basics
if(TRUE) {
  remote <- "https://datasets.imdbws.com/name.basics.tsv.gz"
  local <- "data/name_basics.tsv.gz"
  name_basics <- read_tsv(remote)
  write_tsv(name_basics, local)
}

# title_akas
if(TRUE) {
  remote <- "https://datasets.imdbws.com/title.akas.tsv.gz"
  local <- "data/title_akas.tsv.gz"
  title_akas <- read_tsv(remote)
  write_tsv(title_akas, local)
}

# title_basics
if(TRUE) {
  remote <- "https://datasets.imdbws.com/title.basics.tsv.gz"
  local <- "data/title_basics.tsv.gz"
  title_basics <- read_tsv(remote)
  write_tsv(title_basics, local)
}

# title_crew
if(TRUE) {
  remote <- "https://datasets.imdbws.com/title.basics.tsv.gz"
  local <- "data/title_basics.tsv.gz"
  title_crew <- read_tsv(remote)
  write_tsv(title_crew, local)
}

# title_episodes
if(TRUE) {
  remote <- "https://datasets.imdbws.com/title.basics.tsv.gz"
  local <- "data/title_basics.tsv.gz"
  title_episodes <- read_tsv(remote)
  write_tsv(title_episodes, local)
}

# title_principles
if(TRUE) {
  remote <- "https://datasets.imdbws.com/title.principles.tsv.gz"
  local <- "data/title_principles.tsv.gz"
  title_principles <- read_tsv(remote)
  write_tsv(title_principles, local)
}

# title_ratings
if(TRUE) {
  remote <- "https://datasets.imdbws.com/title.ratings.tsv.gz"
  local <- "data/title_ratings.tsv.gz"
  title_ratings <- read_tsv(remote)
  write_tsv(title_ratings, local)
}