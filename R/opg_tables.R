build_opg_tables <- function(SQL) {

cover_df <- read.csv(system.file("pages/cover.csv", package = "opgstats"),check.names=FALSE)
notes_df <- read.csv(system.file("pages/notes.csv", package = "opgstats"),check.names=FALSE)
tables_df <- read.csv(system.file("pages/contents.csv", package = "opgstats"),check.names=FALSE)

# SQL <- "SELECT * FROM sirius_derived_dev_dbt.opg_family_court_stats_published"

data <- mojstats::query_athena(SQL)

extract_date <- trimws(format(unique(data$extract_date), "%e %B %Y"))

mojstats::build_stats_tables(data,
                   c("case_type","case_subtype","gender","age_band"),
                   "count",
                   title = "Office of the Public Guardian Statistics",
                   cover_df,
                   notes_df,
                   tables_df,
                   "output.xlsx")

}

build_published_opg_tables <- function() {

  build_opg_tables("SELECT * FROM sirius_derived_dev_dbt.opg_family_court_stats_published")

}

build_latest_opg_tables <- function() {

  build_opg_tables("SELECT * FROM sirius_derived_dev_dbt.opg_family_court_stats_latest")

}
