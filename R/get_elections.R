
#' Extract data from CEPESPData
#'
#' @description
#'
#' The get_* functions from cepespR extract alternative slices of
#' the processed TSE data avaiable at CEPESPData.
#'
#' * \code{get_elections()} is the most comprehensive function which
#'     merges data on election results, candidates and coalitions to
#'     enable more complex analysis. Be aware that this function still is in development.
#'
#' * \code{get_votes()} extracts details about the number of votes won by each
#'     candidate in a specific election.
#'
#' * \code{get_candidates()} extracts details about the characteristics of individual
#'     candidates competing in an election.
#'
#' * \code{get_coalitions()} extracts details about the parties that constitute each
#'     coalition that competed in each election.
#'
#' @param year a integer scalar.
#'
#' @param state character vector. Default value is "all".
#'
#' @param regional_aggregation character with desired regional aggregation.
#'
#' @param political_aggregation character with desired political aggregation.
#'
#' @param position a character or integer scalar with the correpondend political contest position.
#'
#' @param cached a logical scalar. If TRUE, \code{cepespdata} will store the dataset inside your computes.
#'  Thus, if the same request is made, the data will be immediately available. Note that if you use
#'  this feature the app will create a sub-directory /static/cache on your working directory to store
#'  the downloaded data. If you are planning to use the functions several times, you should considers setting the parameter to TRUE.
#'
#' @param columns_list a list with the columns needed. If supplied, \code{cepespdata} will return only the
#' specified variables.
#'
#' @param party Optional character with a specified party.
#'
#' @param candidate_number Optional integer scalar.
#'
#' @section Warning:
#'
#' \code{get_elections()} is a function in development. Thus, merges performed by it remain
#'  imperfect due to errors in the underlying TSE data and so this function should be
#'  treated as beta and used with caution.
#'
#' @section Selecting Variables:
#'
#' The default setting is for the function to return all the available variables (columns).
#' To select specific variables and limit the size of the request, you can specify a list
#' of required columns in the columns_list property. The specific columns available depend
#' on the political and regional aggregation selected so you are advised to refer to the API
#' documentation at \url{https://github.com/Cepesp-Fgv/cepesp-rest} for further details.
#'
#' @section Filters:
#'
#' To limit the size of the data returned by the API, the request can be filtered to
#' return data on specific units: By state (using the two-letter abbreviation, eg. "RJ");
#' by party (using the two-digit official party number, eg. 45), or by candidate number.
#'
#' @section Cache:
#'
#' Each time a request is made to the cepespR API, the specific dataset is constructed
#' and downloaded to your local system. To limit processing and bandwidth utilization,
#' the cepespR package includes the option to cache your requests so that they are stored
#' locally and immediately available when that request is repeated.
#'
#' Note that if you use this feature the app will create a sub-directory /static/cache of
#' your working directory to store the downloaded data. You can manually delete this data to
#' force a new download the next time the same request is made.
#'
#' @export
#'
#' @examples
#'
#' \dontrun{
#' # Basic use of get_* functions.
#'
#' data <- get_elections(year = 2014, position = "Federal Deputy")
#'
#' data <- get_votes(year = 2014, position = "Federal Deputy")
#'
#' data <- get_candidates(year = 2014, position = "Federal Deputy")
#'
#' data <- get_coalitions(year = 2014, position = "Federal Deputy")
#'
#' # If needed, it is possible to change regional and political aggregation
#'
#' data <- get_elections(year = 2014,
#'                       position = "Federal Deputy",
#'                       regional_aggregation = "State",
#'                       political_aggregation = "Party")
#' }

#' @rdname get_elections
#' @export

get_elections <- function(year, position, state = "all", 
                          regional_aggregation = "Municipality", 
                          political_aggregation = "Candidate",
                          cached = FALSE, columns_list = list(), 
                          party = NULL, candidate_number = NULL, 
                          only_elected = FALSE, dev = FALSE,
                          blank_votes = FALSE, null_votes = FALSE, lambda = FALSE) {

  regional_aggregation <- switch_regional_aggregation(regional_aggregation)
  
  political_aggregation <- switch_political_aggregation(political_aggregation)
  
  position <- switch_position(position)

  if(is.null(political_aggregation))
    
    stop('Unknown political_aggregation. Check if there is any mispelling error.')

  if(is.null(regional_aggregation))
    
    stop('Unknown regional_aggregation. Check if there is any mispelling error.')

  return(
    
    query(build_params(
      table                 = "tse",
      year                  = year,
      uf                    = state,
      regional_aggregation  = regional_aggregation,
      political_aggregation = political_aggregation,
      position              = position,
      columns_list          = columns_list,
      party                 = party,
      candidate_number      = candidate_number,
      default_columns       = columns(regional_aggregation, political_aggregation),
      only_elected          = only_elected,
      blank_votes           = blank_votes,
      null_votes            = null_votes
    
      ), cached, dev, lambda)
  )
}

#' @rdname get_votes
#' @export

get_votes <- function(year, position, regional_aggregation = "Municipality", 
                      state = "all", cached = FALSE, columns_list = list(),
                      party = NULL, candidate_number = NULL, dev = FALSE, 
                      blank_votes = FALSE, null_votes = FALSE, lambda = FALSE) {
  
  prev_reg <- regional_aggregation
  
  regional_aggregation <- switch_regional_aggregation(regional_aggregation)
  
  position <- switch_position(position)

  if(is.null(regional_aggregation))
    
    stop('Unknown regional_aggregation. Check if there is any mispelling error.')

  return(
    
    query(build_params(
      table                 = "votos",
      year                  = year,
      uf                    = state,
      regional_aggregation  = regional_aggregation,
      political_aggregation = 0,
      position              = position,
      columns_list          = columns_list,
      party                 = party,
      candidate_number      = candidate_number,
      default_columns       = columns_votes_sec(regional_aggregation),
      blank_votes           = blank_votes,
      null_votes            = null_votes
    
      ), cached, dev, lambda)
  )
}

#' @rdname get_candidates
#' @export

get_candidates <- function(year, position, cached = FALSE, 
                           columns_list = list(), party = NULL, 
                           candidate_number = NULL, only_elected = FALSE, 
                           dev = FALSE, lambda = FALSE) {
  
  position <- switch_position(position)
  
  return(
    
    query(build_params(
      table                 = "candidatos",
      year                  = year,
      uf                    = "all",
      regional_aggregation  = 0,
      political_aggregation = 0,
      position              = position,
      columns_list          = columns_list,
      party                 = party,
      candidate_number      = candidate_number,
      default_columns       = columns_candidates(),
      only_elected          = only_elected
    
      ), cached, dev, lambda)
  )
}

#' @rdname get_coalitions
#' @export

get_coalitions <- function(year, position, columns_list = list(), 
                           party = NULL, cached = FALSE, 
                           dev = FALSE, lambda = FALSE) {
  
  position <- switch_position(position)
  
  return (
    
    query(build_params(
      table                 = "legendas",
      year                  = year,
      uf                    = "all",
      regional_aggregation  = 0,
      political_aggregation = 0,
      position              = position,
      columns_list          = columns_list,
      party                 = party,
      default_columns       = columns_political_parties()
    
      ), cached, dev, lambda)
  )
}

#' @rdname get_assets
#' @export

get_assets <- function(year, state = "all", 
                       columns_list = list(), 
                       cached = FALSE, 
                       dev = FALSE, lambda = FALSE) {
  
  return(
    query(build_params(
      table                 = "bem_candidato",
      year                  = year,
      uf                    = state,
      regional_aggregation  = 0,
      political_aggregation = 0,
      position              = 0,
      columns_list          = columns_list,
      party                 = NULL,
      default_columns       = columns_bens_candidatos()
  
        ), cached, dev, lambda)
  )
}

#' @rdname get_secretaries
#' @export

get_secretaries <- function(state = "all", name = NULL, 
                            period = NULL, columns_list = list(), 
                            cached = FALSE, dev = FALSE, 
                            lambda = FALSE) {
  
  return(
    
    query(build_params(
      table                 = "secretarios",
      year                  = 0,
      uf                    = state,
      name                  = name,
      regional_aggregation  = 0,
      political_aggregation = 0,
      position              = 0,
      government_period     = period,
      columns_list          = columns_list,
      party                 = NULL,
      default_columns       = columns_secretaries()
    
      ), cached, dev, lambda)
  )
}

#' @rdname get_careers
#' @export

get_careers <- function(NOME_CANDIDATO = NULL, 
                        NOME_URNA_CANDIDATO = NULL) {
  
  url = httr::modify_url("https://cepesp-app.herokuapp.com/api/dim/candidato", 
                         query = list(
                           NOME_CANDIDATO = NOME_CANDIDATO,
                           NOME_URNA_CANDIDATO = NOME_URNA_CANDIDATO
                           ))

  return(jsonlite::fromJSON(url)[['data']])
}

#' @rdname get_careers_elections
#' @export

get_careers_elections <- function(NUM_TITULO_ELEITORAL_CANDIDATO = NULL, 
                                  ID_DIM_CANDIDATO = NULL) {
  
  url = httr::modify_url("https://cepesp-app.herokuapp.com/api/candidatos", 
                         query = list(NUM_TITULO_ELEITORAL_CANDIDATO = NUM_TITULO_ELEITORAL_CANDIDATO,
                                      ID_DIM_CANDIDATO = ID_DIM_CANDIDATO
                                      ))

  return(jsonlite::fromJSON(url)[['data']])
  
}
