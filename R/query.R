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
  names(columns_list) <- rep("selected_columns[]",length(columns_list))
  consulta <- append(list(anos=year,agregacao_regional=regional_aggregation, agregacao_politica=political_aggregation, cargo=position), columns_list)
  consulta <- add_filter(consulta, columns_list, "NUMERO_PARTIDO", party)
  consulta <- add_filter(consulta, columns_list, "UF", uf)
  consulta <- add_filter(consulta, columns_list, "NUMERO_CANDIDATO", candidate_number)
  return(consulta)
}

add_filter <- function(consulta, columns_list, column, value) {

  if(is.null(value) || value=="all")
    return(consulta)

  if(column %in% columns_list) {
    column_name <- paste0("columns[",filter_index,"][name]")
    search_name <- paste0("columns[",filter_index,"][search][value]")
    consulta <- append(consulta, setNames(column, column_name))
    consulta <- append(consulta, setNames(value, search_name))
    assign("filter_index", filter_index + 1, envir = .GlobalEnv)
    return(consulta)
  }
  stop(paste(column, "column is required"))
  return(consulta)
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