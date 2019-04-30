#' @import stats
#' @import utils

base_url    <- "http://cepesp.io/"
dev_base_url <- "http://test.cepesp.io/"
#dev_base_url   <- "http://127.0.0.1:5000/"
api_version <- "1.0.2"

load_from_cache <- function(query_id) {
  if(file.exists(query_id)){
    return(read.csv(query_id, sep=",", header=T, quote = "\""))
  } else {
    return(NULL)
  }
}

save_on_cache <- function(query_id, data) {
  gz1 <- gzfile(query_id, "w")
  write.csv(data, gz1)
  close(gz1)
}

hash_r <- function(request, extension=".gz") {
  folder = "static/cache/"
  if (!dir.exists(folder))
    dir.create(folder, recursive = TRUE)

  return(paste0(folder, digest::digest(do.call(paste, c(as.list(request), sep=""))), extension))
}

build_params <- function(table, year, uf, regional_aggregation, political_aggregation = NULL, position, columns_list, government_period=NULL, default_columns=list(), name=NULL, party=NULL, candidate_number=NULL, only_elected=FALSE) {

  if(length(columns_list) == 0) {
    columns_list <- default_columns
  }

  names(columns_list) <- rep("c[]", length(columns_list))
  params <- append(list(anos=year,agregacao_regional=regional_aggregation, agregacao_politica=political_aggregation, cargo=position), columns_list)

  if (!is.null(uf) && uf != "all") {
    params <- append(params, list(uf_filter=uf))
  }

  if (!is.null(party) && party != "all") {
    if (table == "filiados") {
      params <- append(params, list(party=party))
    } else {
      params <- add_filter(params, "NUMERO_PARTIDO", party)
    }
  }

  if (!is.null(government_period)) {
    params <- append(params, list(government_period=government_period))
  }

  if (!is.null(name) && table == "secretarios") {
    params <- append(params, list(name_filter=name))
  }

  params <- add_filter(params, "NUMERO_CANDIDATO", candidate_number)
  params <- append(params, list(table=table))
  if (only_elected) {
    params <- append(params, list(only_elected=1))
  }

  print(params)

  return(params)
}

add_filter <- function(params, column, value) {

  if(is.null(value) || value=="all")
    return(params)

  column_name <- paste0("filters[",column,"]")
  params <- append(params, setNames(value, column_name))

  return(params)
}

switch_numeric <- function(number, values) {
  if (number %in% values)
    return(number)
  else
    return(NULL)
}

switch_regional_aggregation <- function(text) {

  if (is.numeric(text))
    return(switch_numeric(text, c(0, 1, 2, 4, 5, 6, 7, 8, 9)))

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
    return(switch_numeric(text, c(1, 2, 3, 4)))

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
      return(switch_numeric(text, c(1, 3, 5, 6, 7, 8, 11, 13)))

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

query_get_id <- function(params, dev=FALSE) {
  base <- if(dev) dev_base_url else base_url
  endpoint <- paste0(base, 'api/consulta/athena/query')
  response <- httr::GET(endpoint, query = params)
  result <- httr::content(response, type = "application/json", encoding = "UTF-8")

  if (httr::status_code(response) == 200) {
    return(result['id'])
  } else {
    stop(result['error'])
  }
}

query_get_status <- function(id, dev=FALSE) {
  base <- if(dev) dev_base_url else base_url
  endpoint <- paste0(base, 'api/consulta/athena/status')
  response <- httr::GET(endpoint, query = list(id=id))
  result <- httr::content(response, type = "application/json", encoding = "UTF-8")

  if (httr::status_code(response) == 200) {
    if (dev) {
      message("id: ", id,", status: ", result['status'])
    }

    return(result['status'])
  } else {
    stop(result['error'])
  }
}

query_get_result <- function(id, dev=FALSE) {
  base <- if(dev) dev_base_url else base_url
  endpoint <- paste0(base, 'api/consulta/athena/result')
  response <- httr::GET(endpoint, query=list(id=id, r_ver=api_version))

  if (httr::status_code(response) == 200) {
    result <- httr::content(response, type="text/csv", encoding = "UTF-8")
    return(result)
  } else {
    result <- httr::content(response, type="application/json", encoding = "UTF-8")
    stop(result['error'])
  }
}

query <- function(params, cached=FALSE, dev=FALSE) {
  query_id = query_get_id(params, dev)
  result <- NULL

  if(cached) {
    result <- load_from_cache(query_id)
  }

  if(is.null(result) || !cached) {
    status = "RUNNING"
    time = 1
    while (status == "RUNNING" || status == "QUEUED") {
      Sys.sleep(time)
      time <- time * 2

      status <- query_get_status(query_id, dev)

      # wait a few more seconds before next checkup
      if (time == 2 && (status == "RUNNING" || status == "QUEUED")) {
        time <- 32
      }
    }

    if (status == "SUCCEEDED") {
      result <- query_get_result(query_id, dev)
    } else {
      error("The query has failed. Please, check if your parameters are valid.")
    }
  }

  if(cached) {
    save_on_cache(query_id, result)
  }

  if (!is.null(result)) {
    names(result) <- toupper(names(result))
  }

  return(result)
}
