
#' @import stats
#' @import utils

base_url    <- "http://cepesp.io/"
dev_base_url <- "http://test.cepesp.io/"
api_version <- "1.0.2"

options(scipen = 99999999)

# 1. cache_get_file() -----------------------------------------------------

cache_get_file <- function(query_id) {
  
  fpath <- paste0(".cepespdata/", 
                  query_id, ".csv")

  if (!dir.exists(".cepespdata/")) {
    
    dir.create(".cepespdata/")
  
    }

  return(fpath)

  }

# 2. cache_exists() -------------------------------------------------------

cache_exists <- function(query_id) {
  
  return(file.exists(cache_get_file(query_id)))

}

# 3. cache_read() ---------------------------------------------------------

cache_read <- function(query_id) {
  
  return(data.table::fread(
    
    cache_get_file(query_id),
    sep = ",",
    header = TRUE,
    encoding = "UTF-8",
    showProgress = TRUE,
    keepLeadingZeros = TRUE
  
    ))

}

# 4. cache_write() --------------------------------------------------------

cache_write <- function(query_id, 
                        result) {
  
  data.table::fwrite(result, 
                     file = cache_get_file(query_id), 
                     sep = ",", 
                     showProgress = TRUE)

}

# 5. hash_r ---------------------------------------------------------------

hash_r <- function(request, 
                   extension = ".gz") {
  
  folder = "static/cache/"
  
  if(!dir.exists(folder))
  
      dir.create(folder, 
                 recursive = TRUE)

  return(paste0(folder, 
                digest::digest(do.call(paste, 
                                       c(as.list(request), 
                                         sep = ""))), 
                extension))

}

# 5. build_params ---------------------------------------------------------

build_params <- function(table, year, uf, regional_aggregation, 
                         political_aggregation = NULL, position, columns_list,
                         government_period = NULL, default_columns = list(), 
                         name = NULL, party = NULL, candidate_number = NULL,
                         only_elected = FALSE, blank_votes = FALSE, null_votes = FALSE) {

  if(length(columns_list) == 0) {
    
    columns_list <- default_columns
  
    }

  names(columns_list) <- rep("c[]", length(columns_list))
  
  params <- append(list(anos = year,
                        agregacao_regional = regional_aggregation, 
                        agregacao_politica = political_aggregation, 
                        cargo = position), 
                   columns_list)

  if(!is.null(uf) && uf != "all") {
    
    params <- append(params, 
                     list(uf_filter = uf))
  
    }

  if(!is.null(party) && party != "all") {
    
      params <- add_filter(params, 
                           "NUMERO_PARTIDO", 
                           party)
      
      }

  if(!is.null(government_period)) {
    
    params <- append(params, 
                     list(government_period = government_period))
  
    }

  if(!is.null(name) && table == "secretarios") {
    
    params <- append(params, 
                     list(name_filter = name))
  
    }

  if(blank_votes) {
    
    params <- append(params, 
                     list(brancos = TRUE))
  
    }

  if(null_votes) {
    
    params <- append(params, 
                     list(nulos = TRUE))
  
    }

  params <- add_filter(params, 
                       "NUMERO_CANDIDATO", 
                       candidate_number)
  
  params <- append(params, 
                   list(table = table))
  
  if(only_elected) {
    
    params <- append(params, 
                     list(only_elected = 1))
  
    }

  return(params)

  }

# 6. add_filter() ---------------------------------------------------------

add_filter <- function(params, 
                       column, 
                       value) {

  if(is.null(value) || value == "all")
    
    return(params)

  column_name <- paste0("filters[", column, "]")
  
  params <- append(params, 
                   setNames(value, column_name))

  return(params)

}

# 7. switch_numeric() -----------------------------------------------------

switch_numeric <- function(number, 
                           values) {
  
  if(number %in% values)
  
      return(number)
  
  else
  
      return(NULL)

  }


# 8. switch_regional_aggregation() ----------------------------------------

switch_regional_aggregation <- function(text) {

  if(is.numeric(text))
    
    return(switch_numeric(text, 
                          c(0, 1, 2, 4, 5, 6, 7, 8, 9, 10)))
  
  return(switch(text,
                "Brazil" = 0,
                "Brasil" = 0,
                "Macro" = 1,
                "State" = 2,
                "Estado" = 2,
                "Meso" = 4,
                "Micro" = 5,
                "Municipality" = 6,
                "Municipio" = 6,
                "Municipality-Zone" = 7,
                "Municipio-Zona" = 7,
                "Zone" = 8,
                "Zona" = 8,
                "Votação Seção" = 9,
                "Ballot Box" = 9,
                "Electoral Section" = 9,
                "Local" = 10,
                "Local Votação" = 10,
                "Location" = 10))

}


# 9. switch_political_aggregation() ---------------------------------------

switch_political_aggregation <- function(text) {

  if(is.numeric(text))
    
    return(switch_numeric(text, 
                          c(1, 2, 3, 4)))

  return(switch(text,
                "Party" = 1,
                "Partido" = 1,
                "Candidate" = 2,
                "Candidato" = 2,
                "Coalition" = 3,
                "Coligacao" = 3,
                "Consolidated" = 4,
                "Consolidado" = 4))

}

# 10. switch_position() ---------------------------------------------------

switch_position <- function(text) {

  if(is.numeric(text))
    
    return(switch_numeric(text, 
                          c(1, 3, 5, 6, 7, 8, 11, 13)))

  return(switch(text,
                "President" = 1,
                "Presidente" = 1,
                "Governor" = 3,
                "Governador" = 3,
                "Senator" = 5,
                "Senador" = 5,
                "Federal Deputy" = 6,
                "Deputado Federal" = 6,
                "State Deputy" = 7,
                "Deputado Estadual" = 7,
                "District Deputy" = 8,
                "Deputado Distrital" = 8,
                "Mayor" = 11,
                "Prefeito" = 11,
                "Councillor" = 13,
                "Vereador" = 13))
  
  }

# 11. query_get_id() ------------------------------------------------------

query_get_id <- function(params, 
                         dev = FALSE) {
  
  base <- if(dev) dev_base_url else base_url
  
  endpoint <- paste0(base, 
                     'api/consulta/athena/query')
  
  ## To ensure uninterrupted package operation during API instability, 
  ## we have increased the code tolerance level, allowing multiple attempts 
  ## before delivering an error message to users.
  
  attempt <- 1 
  status <- 0 
  
  while(status %in% c(0,
                      500) & 
        attempt < 5){           
    
    message("Getting query ID. Attempt #", attempt, ".", sep = "")
   
    response <- httr::GET(endpoint, 
                          query = params) 
    
    attempt <- attempt + 1
    status <- httr::status_code(response)
    
  }
  
  result <- httr::content(response, 
                          type = "application/json", 
                          encoding = "UTF-8")

  if(httr::status_code(response) == 200) {
    
    return(result['id'])
  
    } else {
    
      stop(result['error'])
      
    }
  }

# 12. query_get_status() --------------------------------------------------

query_get_status <- function(id, 
                             dev = FALSE) {
  
  base <- if(dev) dev_base_url else base_url
  
  endpoint <- paste0(base, 
                     'api/consulta/athena/status')
  
  ## To ensure uninterrupted package operation during API instability, 
  ## we have increased the code tolerance level, allowing multiple attempts 
  ## before delivering an error message to users.
  
  attempt <- 1 
  status <- 0 
  
  while(status %in% c(0,
                      500) & 
        attempt < 5){           
    
    response <- httr::GET(endpoint, 
                          query = list(id = id))
    
    attempt <- attempt + 1
    status <- httr::status_code(response)
    
  }
  
  result <- httr::content(response, type = "application/json", 
                          encoding = "UTF-8")

  if(httr::status_code(response) == 200) {
    
    return(result['status'])
  
    } else {
    
    stop(result['error'])
      
      }

}

# 13. query_get_result() --------------------------------------------------

query_get_result <- function(id,
                             dev = FALSE) {
  
  base <- if(dev) dev_base_url else base_url
  
  endpoint <- paste0(base, 
                     'api/consulta/athena/result')
  
  url <- httr::modify_url(endpoint, 
                          query = list(id = id, 
                                       r_ver = api_version))
  
  ## To ensure uninterrupted package operation during API instability, 
  ## we have increased the code tolerance level, allowing multiple attempts 
  ## before delivering an error message to users. 
  
  req <- httr::RETRY(verb = "GET", 
                     url = url, 
                     times = 5,
                     quiet = FALSE, 
                     terminate_on = NULL,
                     encode = "raw")

  message("\nParsing downloaded csv...")
  
  suppressMessages(
  
    result <- httr::content(req, 
                          as = "parsed", 
                          type = "text/csv", 
                          encoding = "UTF-8")
    )

  if(!is.null(result)) {
    
    names(result) <- toupper(names(result))
  
    }
  
  return(result)

}

# 14. query_wait() --------------------------------------------------------

query_wait <- function(query_id, 
                       dev = FALSE) {
  
  status <- "RUNNING"
  time <- 1

  while (status == "RUNNING" || 
         status == "QUEUED") {
    
    Sys.sleep(time)
    
    status <- query_get_status(query_id, dev)
    
    message("status: ", status, ", elapsed: ", time, "s")

    if (time == 1 && (status == "RUNNING" || 
                      status == "QUEUED")) {
      
      ## Wait a few more seconds before next checkup
      
      time <- 16
    
      } else {
      
        time <- time + 2
    
      }
    }

  return(status)
  
}

# 15. query_athena() ------------------------------------------------------

query_athena <- function(params, 
                         cached, 
                         dev) {
  
  result <- NULL
  
  query_id <- query_get_id(params, 
                           dev)

  if(dev) {
    
    message("query-id: ", query_id)
  
    }

  if(cached && cache_exists(query_id)) {
    
    message("Reading from cache.")
    
    result <- cache_read(query_id)
  
    }

  if(is.null(result) || 
     !cached) {
    
    status <- query_wait(query_id, 
                         dev)

    if(status == "SUCCEEDED") {
      
      result <- query_get_result(query_id, 
                                 dev)

      if(cached) {
        
        cache_write(query_id, 
                    result)
      
        }
    } else {
      
      stop("The query has failed. Please, check if your parameters are valid.")
    
      }
  
    }

  return(result)

}

# 16. query_lambda() ------------------------------------------------------

query_lambda <- function(params, 
                         cached, 
                         dev) {
  
  endpoint <- "https://api.cepespdata.io/api/query"
  
  url <- httr::modify_url(endpoint, 
                          query=params)
  
  tmp <- tempfile()
  
  req <- curl::curl_download(url, 
                             tmp, 
                             quiet = FALSE)

  message("\nParsing downloaded csv...")
  
  result <- data.table::fread(
    file = tmp,
    sep = ",",
    header = TRUE,
    encoding = "UTF-8",
    showProgress = TRUE,
    keepLeadingZeros = TRUE
  )

  if(!is.null(result)) {
    
    names(result) <- toupper(names(result))
  
    }

  return(result)

}

# 17. query() -------------------------------------------------------------

query <- function(params, 
                  cached = FALSE, 
                  dev = FALSE, 
                  lambda = FALSE) {
  
  if(lambda == FALSE) {
    
    return(query_athena(params, cached, dev))
  
    } else {
    
      return(query_lambda(params, cached, dev))
  
    }
  }
