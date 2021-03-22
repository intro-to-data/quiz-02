# Data Dictionary

This is the data dictionary for the IMDB data.
Most of the information here was pulled from [the IMDB website](https://www.imdb.com/interfaces/).

This data contains TWO different ID numbers:

- tconst (string): alphanumeric unique identifier for a title (movie, tv show, etc.)
- nconst (string): alphanumeric unique identifier of the name/person

These columns are used as primary keys or foreign keys throughout the data. The role of the column is listed in the data dictionary below. Remember, a PRIMARY KEY cannot repeat in that table. However, a foreign key can. For example:

```
title_basics %>% inner_join(title_principals, by = "tconst")
```

- The table, `title_basics` contains the basic info for each title. Each title (tconst) has exactly one row. Therefore, tconst is the PRIMARY KEY.
- The table, `title_principals` contains information about cast/crew on each title. Obviously, a movie/show has more than one person on the cast and crew, so tconst will have many entries for EACH show.
- We can JOIN these two tables, using tconst, to identify information about cast/crew.

All tables have been shortened to include movies and shows from the 90s. This means a show or movie was around for at least some part of the greatest decade of them all, the 90s. Otherwise, this data set is just too big.

The primary identifier throughout this data is tconst. And IMDB uses this identifier pervasively. For example, tt0409847 is the tconst for the eponymous 2011 movie Cowboys & Aliens. All records pertaining to this movie can be found by filtering one or more tables to `tconst == "tt0409847"`. They also use this tconst in their uesr interface. The URL for the movie is https://www.imdb.com/title/tt0409847/.

## Present

### title_basics

Contains the following information for titles:

- tconst (string): PRIMARY KEY
- titleType (string) – the type/format of the title (e.g. movie, short, tvseries, tvepisode, video, etc)
- primaryTitle (string) – the more popular title / the title used by the filmmakers on promotional materials at the point of release
- originalTitle (string): original title, in the original language
- isAdult (boolean): 0: non-adult title; 1: adult title
- startYear (YYYY) – represents the release year of a title. In the case of TV Series, it is the series start year
- endYear (YYYY) – TV Series end year. ‘\N’ for all other title types
- runtimeMinutes – primary runtime of the title, in minutes

In title_basics, the column tconst is a primary key. This means it does not repeat.

### title_genres

- tconst (string): FOREIGN KEY
- genre (string): genres associated with the title

Extracted from title_basics during import. While the data itself is unchanged, get_imdb_data.R creates a separate table for genre information because each title could be associated with up to three genres in an array.

For example:

| tconst | genres         |
|:------:|:---------------|
| 00001  | action, comedy |

This would make analysis more complicated, so the import script created a new table, title_genres, which contains this information expressed as a relational data. In title_genres, the tconst column is a foreign key which can be used to join to any other tconst instance. Because tconst is a foreign key in this table, it can (and does) repeat.

### title_principals

Contains the principal cast/crew for titles

- tconst (string): FOREIGN KEY
- ordering (integer) – a number to uniquely identify rows for a given titleId
- nconst (string): FOREIGN KEY
- category (string): the category of job that person was in
- job (string): the specific job title if applicable, else '\N'
- characters (string): the name of the character played if applicable, else '\N'

### title_ratings

Contains the IMDb rating and votes information for titles

- tconst (string): FOREIGN KEY
- averageRating: weighted average of all the individual user ratings
- numVotes: number of votes the title has received

## Omitted

### name_basics

Contains the following information for names:

- nconst (string): PRIMARY KEY
- primaryName (string)– name by which the person is most often credited
- birthYear – in YYYY format
- deathYear – in YYYY format if applicable, else '\N'
- primaryProfession (array of strings)– the top-3 professions of the person
- knownForTitles (array of tconsts) – titles the person is known for

### title_akas

Although this data is part of the official IMDB data, it is not part of our data set unless enabled in get_imdb_data.R. Contains the following information for titles:

- titleId (string): a tconst, an alphanumeric unique identifier of the title
- ordering (integer) – a number to uniquely identify rows for a given titleId
- title (string) – the localized title
- region (string): the region for this version of the title
- language (string): the language of the title
- types (array): Enumerated set of attributes for this alternative title. One or more of the following: "alternative", "dvd", "festival", "tv", "video", "working", "original", "imdbDisplay". New values may be added in the future without warning
- attributes (array): Additional terms to describe this alternative title, not enumerated
- isOriginalTitle (boolean) – 0: not original title; 1: original title

### title_episode

Contains the tv episode information. Fields include:

- tconst (string): alphanumeric identifier of episode
- parentTconst (string): alphanumeric identifier of the parent TV Series
- seasonNumber (integer) – season number the episode belongs to
- episodeNumber (integer) – episode number of the tconst in the TV series

### title_crew

Contains the director and writer information for all the titles in IMDb. Fields include:

- tconst (string): FOREIGN KEY
- directors (array of nconsts): director(s) of the given title
- writers (array of nconsts) – writer(s) of the given title
