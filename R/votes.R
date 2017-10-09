# Hello, world!
#
# This is an example function named 'hello'
# which prints 'Hello, world!'.
#
# You can learn more about package authoring with RStudio at:
#
#   http://r-pkgs.had.co.nz/
#
# Some useful keyboard shortcuts for package authoring:
#
#   Build and Reload Package:  'Cmd + Shift + B'
#   Check Package:             'Cmd + Shift + E'
#   Test Package:              'Cmd + Shift + T'

source("R/columns.R")
source("R/query.R")


## Votação Seção [BETA]
votes <- function(year=2014, uf="all", regional_aggregation=5, political_aggregation=2, position=1, cached=FALSE, columns_list=list(), party=NULL, candidate_number=NULL) {
  return (
    query(
      endpoint="tse",
      year=year,
      uf=uf,
      regional_aggregation=regional_aggregation,
      political_aggregation=political_aggregation,
      position=position,
      columns_list=columns_list,
      party=party,
      candidate_number=candidate_number,
      cached=cached,
      default_columns=columns(regional_aggregation, political_aggregation)
    )
  )
}

## Votação Seção [BETA]
votes_sec <- function(year=2014, regional_aggregation=5, position=1, cached=FALSE, columns_list=list(), uf="all", party=NULL, candidate_number=NULL) {
  return (
    query(
      endpoint="votos",
      year=year,
      uf=uf,
      regional_aggregation=regional_aggregation,
      political_aggregation=0,
      position=position,
      columns_list=columns_list,
      party=party,
      candidate_number=candidate_number,
      cached=cached,
      default_columns=columns_votes_sec()
    )
  )
}

## Candidatos
candidates <- function(year=2014, position=1, cached=FALSE, columns_list=list(), uf="all", party=NULL, candidate_number=NULL) {
  return (
    query(
      endpoint="candidatos",
      year=year,
      uf=uf,
      regional_aggregation=0,
      political_aggregation=0,
      position=position,
      columns_list=columns_list,
      party=party,
      candidate_number=candidate_number,
      cached=cached,
      default_columns=columns_candidates()
    )
  )
}

## Legendas
political_parties <- function(year=2014, position=1, cached=FALSE, columns_list=list(), uf="all", party=NULL) {
  return (
    query(
      endpoint="legendas",
      year=year,
      uf=uf,
      regional_aggregation=0,
      political_aggregation=0,
      position=position,
      columns_list=columns_list,
      party=party,
      cached=cached,
      default_columns=columns_political_parties()
    )
  )
}

