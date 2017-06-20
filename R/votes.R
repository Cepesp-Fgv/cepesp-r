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


url <- "http://api.cepesp.io/api/consulta/tse"
#url <- "http://127.0.0.1:5000/api/consulta/tse"
base_url <- "http://api.cepesp.io/"


votes <- function(year=2014, uf="all", regional_aggregation=5,political_aggregation=2, position=1,cached=FALSE, columns_list=list(),party=NULL) {
  consulta <- build_request_parameters(year, uf, regional_aggregation,political_aggregation, position, columns_list, party)
  data = load_from_cache(consulta)
  if(is.null(data) || !cached){
    resp <- GET(url, query=consulta)
    data <- content(resp)
    save_on_cache(request = consulta,data)
  }
  return(data)
}

load_from_cache <- function(request){
  if(file.exists(hash_r(request)))
    return(read.csv(hash_r(request),sep=",",header = T,quote = "\""))
  else
    return(NULL)
}

save_on_cache <- function(request,data){
  gz1 <- gzfile(hash_r(request), "w")
  write.csv(data, gz1)
  close(gz1)
}

hash_r <- function(request,extension=".gz"){
  return(paste0("static/cache/",digest(do.call(paste, c(as.list(request), sep=""))), extension))
}

build_request_parameters <- function(year, uf, regional_aggregation,political_aggregation, position, columns_list,party=NULL){
  if(length(columns_list) == 0) {
    columns_list <- columns(regional_aggregation,political_aggregation)
  }else{
    test_columns(regional_aggregation,political_aggregation,columns_list)
  }
  names(columns_list) <- rep("selected_columns[]",length(columns_list))
  consulta <- append(list(anos=year,agregacao_regional=regional_aggregation,agregacao_politica=political_aggregation,cargo=position),columns_list)
  if (uf!="all"){
    test_uf(uf)
    filter_uf <- list("columns[0][name]"="UF","columns[0][search][value]"=uf)
    consulta = append(consulta,filter_uf)
  }
  if (!is.null(party)){
    filter_party <- list("columns[1][name]"="NUMERO_PARTIDO","columns[1][search][value]" = party)
    consulta = append(consulta,filter_party)
  }
  print(consulta)

  return(consulta)
}
