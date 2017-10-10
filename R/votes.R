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
cepespdata <- function(year=2014, state="all", regional_aggregation=5, political_aggregation=2, position=1, cached=FALSE, columns_list=list(), party=NULL, candidate_number=NULL) {
  return (
    query(
      endpoint="tse",
      year=year,
      uf=state,
      regional_aggregation=switch(regional_aggregation,"Brazil"=0,"Brasil"=0, "Macro"=1,"State"=2,"Estado"=2,"Meso"=4 ,"Micro"=5,"Municipality"=6,"Municipio"=6,"Municipality-Zone"=7,"Municipio-Zona"=7,"Zone"=8,"Zona"=8),
      political_aggregation=switch(political_aggregation,"Party"=1,"Partido"=1,"Candidate"=2,"Candidato"=2,"Coalition"=3,"Coligacao"=3,"Consolidated"=4,"Consolidado"=4),
      position=switch(position,"President"=1,"Presidente"=1,"Governor"=3,"Governador"=3,"Sentaor"=5,"Senador"=5,"Federal Deputy"=6,"Deputado Federal"=6,"State Deputy"=7,"Deputado Estadual"=7,"District Deputy"=8,"Deputado Districal"=8,"Mayor"=11,"Prefeito"=11,"Councillor"=13,"Vereador"=13),
      columns_list=columns_list,
      party=party,
      candidate_number=candidate_number,
      cached=cached,
      default_columns=columns(regional_aggregation, political_aggregation)
    )
  )
}

## Votação Seção
votes <- function(year=2014, regional_aggregation=5, position=1, cached=FALSE, columns_list=list(), state="all", party=NULL, candidate_number=NULL) {
  return (
    query(
      endpoint="votos",
      year=year,
      uf=state,
      regional_aggregation=switch(regional_aggregation,"Brazil"=0,"Brasil"=0, "Macro"=1,"State"=2,"Estado"=2,"Meso"=4 ,"Micro"=5,"Municipality"=6,"Municipio"=6,"Municipality-Polling Station"=7,"Municipio-Zona"=7,"Polling Station"=8,"Zona"=8),
      political_aggregation=0,
      position=switch(position,"President"=1,"Presidente"=1,"Governor"=3,"Governador"=3,"Senator"=5,"Senador"=5,"Federal Deputy"=6,"Deputado Federal"=6,"State Deputy"=7,"Deputado Estadual"=7,"District Deputy"=8,"Deputado Districal"=8,"Mayor"=11,"Prefeito"=11,"Councillor"=13,"Vereador"=13),
      columns_list=columns_list,
      party=party,
      candidate_number=candidate_number,
      cached=cached,
      default_columns=columns_votes_sec()
    )
  )
}

## Candidatos
candidates <- function(year=2014, position=1, cached=FALSE, columns_list=list(), state="all", party=NULL, candidate_number=NULL) {
  return (
    query(
      endpoint="candidatos",
      year=year,
      uf=state,
      regional_aggregation=0,
      political_aggregation=0,
      position=switch(position,"President"=1,"Presidente"=1,"Governor"=3,"Governador"=3,"Senator"=5,"Senador"=5,"Federal Deputy"=6,"Deputado Federal"=6,"State Deputy"=7,"Deputado Estadual"=7,"District Deputy"=8,"Deputado Districal"=8,"Mayor"=11,"Prefeito"=11,"Councillor"=13,"Vereador"=13),
      columns_list=columns_list,
      party=party,
      candidate_number=candidate_number,
      cached=cached,
      default_columns=columns_candidates()
    )
  )
}

## Legendas
coalitions <- function(year=2014, position=1, cached=FALSE, columns_list=list(), state="all", party=NULL) {
  return (
    query(
      endpoint="legendas",
      year=year,
      uf=state,
      regional_aggregation=0,
      political_aggregation=0,
      position=switch(position,"President"=1,"Presidente"=1,"Governor"=3,"Governador"=3,"Senator"=5,"Senador"=5,"Federal Deputy"=6,"Deputado Federal"=6,"State Deputy"=7,"Deputado Estadual"=7,"District Deputy"=8,"Deputado Districal"=8,"Mayor"=11,"Prefeito"=11,"Councillor"=13,"Vereador"=13),
      columns_list=columns_list,
      party=party,
      cached=cached,
      default_columns=columns_political_parties()
    )
  )
}
