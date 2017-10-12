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


## Votação Seção ("por cargo") [BETA]
cepespdata <- function(year=2014, state="all", regional_aggregation="Municipality", political_aggregation="Candidate", position="President", cached=FALSE, columns_list=list(), party=NULL, candidate_number=NULL) {
  regional_aggregation <- switch_regional_aggregation(regional_aggregation)
  political_aggregation <- switch_political_aggregation(political_aggregation)
  position <- switch_position(position)

  return (
    query(
      endpoint="tse",
      year=year,
      uf=state,
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

## Votação Seção
votes <- function(year=2014, regional_aggregation="Municipality", position="President", cached=FALSE, columns_list=list(), state="all", party=NULL, candidate_number=NULL) {
  regional_aggregation <- switch_regional_aggregation(regional_aggregation)
  position <- switch_position(position)

  return (
    query(
      endpoint="votos",
      year=year,
      uf=state,
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
candidates <- function(year=2014, position="President", cached=FALSE, columns_list=list(), state="all", party=NULL, candidate_number=NULL) {
  position <- switch_position(position)
  return (
    query(
      endpoint="candidatos",
      year=year,
      uf=state,
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
coalitions <- function(year=2014, position="President", cached=FALSE, columns_list=list(), state="all", party=NULL) {
  position <- switch_position(position)
  return (
    query(
      endpoint="legendas",
      year=year,
      uf=state,
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
