# get_imdb_data.R
# Downloads IMDB data.
library(io)
library(tidyr)
library(tidyverse)



## DATA =======================================================================

if (TRUE) {
  data_files <- list_files("./data", pattern = "tsv.gz", full.name = TRUE)
  if (length(data_files) > 0 ) {
    rm(data_files)
    message("All saved data deleted.")
  } else {
    message("I don't see any files to delete.")
    message("I will download the data and save it locally.")
  }
}

# title_basics
if(TRUE) {
  remote <- "https://datasets.imdbws.com/title.basics.tsv.gz"
  local <- "data/title_basics.tsv.gz"
  title_basics <- 
    read_tsv(remote) %>%
    filter(
      between(startYear, 1990, 1999) | between(endYear, 1990, 1999) | (startYear <= 1999 & is.na(endYear))
      )
  
  title_filter <- title_basics %>% select(tconst)
  
  if (max(str_count(title_basics$genres, ",") + 1) > 3) {
    stop("At least one movie has more than three genres.")
  }
  
  ##  Extracts the genre data and creates a new table.
  new_col_names <- c("First", "Second", "Third")
  title_genres <- 
    title_basics %>% 
    select(tconst, genres) %>%
    separate(genres, into = new_col_names) %>%
    pivot_longer(cols = new_col_names, names_to = "genre_priority", values_to = "genre") %>%
    filter(!is.na(genre))
  
  write_tsv(title_genres, "data/title_genres.tsv.gz")
  write_tsv(title_basics %>% select(-genres), local)
}

# name_basics
if(FALSE) {
  ## TODO: Implement filter.
  remote <- "https://datasets.imdbws.com/name.basics.tsv.gz"
  local <- "data/name_basics.tsv.gz"
  name_basics <- read_tsv(remote)
  write_tsv(name_basics, local)
  write_tsc()
}

# title_akas
if(FALSE) {
  ## TODO: Implement filter.
  remote <- "https://datasets.imdbws.com/title.akas.tsv.gz"
  local <- "data/title_akas.tsv.gz"
  title_akas <- read_tsv(remote)
  write_tsv(title_akas, local)
}

# title_crew
if(FALSE) {
  remote <- "https://datasets.imdbws.com/title.crew.tsv.gz"
  local <- "data/title_basics.tsv.gz"
  title_crew <- 
    read_tsv(remote) %>% 
    inner_join(title_filter, by = "tconst")
  write_tsv(title_crew, local)
}

# title_episodes
if(FALSE) {
  ## TODO: Implement/test filter.
  remote <- "https://datasets.imdbws.com/title.episodes.tsv.gz"
  local <- "data/title_basics.tsv.gz"
  title_episodes <- 
    read_tsv(remote)  %>% 
    inner_join(title_filter, by = "tconst")
  write_tsv(title_episodes, local)
}

# title_principals
if(FALSE) {
  remote <- "https://datasets.imdbws.com/title.principals.tsv.gz"
  local <- "data/title_principals.tsv.gz"
  title_principals <- 
    read_tsv(remote)  %>% 
    inner_join(title_filter, by = "tconst")
  write_tsv(title_principals, local)
}

# title_ratings
if(TRUE) {
  remote <- "https://datasets.imdbws.com/title.ratings.tsv.gz"
  local <- "data/title_ratings.tsv.gz"
  title_ratings <- 
    read_tsv(remote)  %>% 
    inner_join(title_filter, by = "tconst")
  write_tsv(title_ratings, local)
}
