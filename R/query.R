library(digest)
library(httr)

#base_url <- "http://127.0.0.1:5000/api/consulta/"
base_url <- "http://cepesp.io/api/consulta/"


load_from_cache <- function(request) {
  if(file.exists(hash_r(request)))
    return(read.csv(hash_r(request),sep=",",header = T,quote = "\""))
  else
    return(NULL)
}

save_on_cache <- function(request, data) {
  gz1 <- gzfile(hash_r(request), "w")
  write.csv(data, gz1)
  close(gz1)
}

hash_r <- function(request, extension=".gz") {
  folder = "static/cache/"
  if (!dir.exists(folder))
    dir.create(folder, recursive = TRUE)

  return(paste0(folder, digest(do.call(paste, c(as.list(request), sep=""))), extension))
}

build_request_url <- function(endpoint) {
  return(paste0(base_url, endpoint))
}


build_request_parameters <- function(year, uf, regional_aggregation, political_aggregation, position, columns_list, party=NULL, candidate_number=NULL){
  assign("filter_index", 0, envir = .GlobalEnv)
  names(columns_list) <- rep("selected_columns[]", length(columns_list))
  consulta <- append(list(anos=year,agregacao_regional=regional_aggregation, agregacao_politica=political_aggregation, cargo=position), columns_list)
  consulta <- add_filter(consulta, "NUMERO_PARTIDO", party)
  consulta <- add_filter(consulta, "UF", uf)
  consulta <- add_filter(consulta, "NUMERO_CANDIDATO", candidate_number)
  return(consulta)
}

add_filter <- function(consulta, column, value) {

  if(is.null(value) || value=="all")
    return(consulta)

  column_name <- paste0("columns[",filter_index,"][name]")
  search_name <- paste0("columns[",filter_index,"][search][value]")
  consulta <- append(consulta, setNames(column, column_name))
  consulta <- append(consulta, setNames(value, search_name))
  assign("filter_index", filter_index + 1, envir = .GlobalEnv)
  return(consulta)
}

switch_regional_aggregation <- function(text) {

  if (is.numeric(text))
    return(text)

  return(switch(text,
                "Brazil"= 0,
                "Brasil"= 0,
                "Macro"= 1,
                "State"= 2,
                "Estado"= 2,
                "Meso"= 4,
                "Micro"= 5,
                "Municipality"= 6,"Municipio"= 6,
                "Municipality-Zone"= 7,
                "Municipio-Zona"= 7,
                "Zone"= 8,
                "Zona"= 8,
                "Votação Seção"= 9,
                "Ballot Box"= 9,
                "Electoral Section"= 9))
}

switch_political_aggregation <- function(text) {

  if (is.numeric(text))
    return(text)

  return(switch(text,
                "Party"= 1,
                "Partido"= 1,
                "Candidate"= 2,
                "Candidato"= 2,
                "Coalition"= 3,
                "Coligacao"= 3,
                "Consolidated"= 4,
                "Consolidado"= 4))
}

switch_position <- function(text) {

  if (is.numeric(text))
    return(text)

  return(switch(text,
                "President"= 1,
                "Presidente"= 1,
                "Governor"= 3,
                "Governador"= 3,
                "Senator"= 5,
                "Senador"= 5,
                "Federal Deputy"= 6,
                "Deputado Federal"= 6,
                "State Deputy"= 7,
                "Deputado Estadual"= 7,
                "District Deputy"= 8,
                "Deputado Distrital"= 8,
                "Mayor"= 11,
                "Prefeito"= 11,
                "Councillor"=13,
                "Vereador"=13))

}


query <- function(endpoint, year, uf, regional_aggregation, political_aggregation, position, columns_list, party=NULL, candidate_number=NULL, cached=FALSE, default_columns=list()) {

  if(length(columns_list) == 0) {
    columns_list <- default_columns
  }

  consulta <- build_request_parameters(year, uf, regional_aggregation, political_aggregation, position, columns_list, party, candidate_number)
  data <- load_from_cache(consulta)

  if(is.null(data) || !cached){
    resp <- GET(build_request_url(endpoint), query=consulta)
    data <- content(resp)
    save_on_cache(request = consulta, data)
  }
  return(data)
}
