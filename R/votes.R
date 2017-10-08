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



#base_url <- "http://127.0.0.1:5000/api/consulta/"
base_url <- "http://cepesp.io/api/consulta/"

if(exists("hash_r", mode = "function"))
  source("manage.R")

votes_url <- function(endpoint) {
  return(p(base_url, endpoint))
}


## Votação Seção [BETA]
votes <- function(year=2014, uf="all", regional_aggregation=5, political_aggregation=2, position=1, cached=FALSE, columns_list=list(), party=NULL, candidate_number=NULL) {
  consulta <- build_request_parameters(year, uf, regional_aggregation,political_aggregation, position, columns_list, party,candidate_number)
  data = load_from_cache(consulta)
  if(is.null(data) || !cached){
    resp <- GET(votes_url("tse"), query=consulta)
    data <- content(resp)
    save_on_cache(request = consulta,data)
  }
  return(data)
}

## Votação Seção [BETA]
votes_sec <- function(year=2014, uf="all", regional_aggregation=5, position=1, cached=FALSE, columns_list=list(), party=NULL, candidate_number=NULL) {
  consulta <- build_request_parameters(year, uf, regional_aggregation,political_aggregation, position, columns_list, party,candidate_number)
  data = load_from_cache(consulta)
  if(is.null(data) || !cached){
    resp <- GET(votes_url("votos"), query=consulta)
    data <- content(resp)
    save_on_cache(request = consulta,data)
  }
  return(data)
}

## Legendas
political_parties <- function(year=2014, position=1, cached=FALSE, columns_list=list(), party=NULL, candidate_number=NULL) {
  consulta <- build_request_parameters(year, uf, regional_aggregation,political_aggregation, position, columns_list, party,candidate_number)
  data = load_from_cache(consulta)
  if(is.null(data) || !cached){
    resp <- GET(votes_url("cadidatos"), query=consulta)
    data <- content(resp)
    save_on_cache(request = consulta,data)
  }
  return(data)
}

