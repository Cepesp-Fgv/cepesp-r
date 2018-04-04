#' Extract data from CEPESPData
#'
#' @description
#'
#' The get_* functions from cepespR extract alternative slices of
#' the processed TSE avaiable at CEPESPData. They by default only need
#' an year and a position.
#'
#' * \code{get_cepespdata()} is the most comprehensive function which
#'     merges data on election results, candidates and coalitions to
#'     enable more complex analysis.
#'
#' * \code{get_votes()}details about the number of votes won by each
#'     candidate in a specific election.
#'
#' * \code{get_candidates()} details about the characteristics of individual
#'     candidates competing in an election.
#'
#' * \code{get_coalitions()} details about the parties that constitute each
#'     coalition that competed in each election.
#'
#' @param year a integer scalar
#'
#' @param state character vector
#'
#' @param regional_aggregation character with desired regional aggregation
#'
#' @param political_aggregation character with desired political aggregation
#'
#' @param position a character or intecer scalar with the correpondend political contest position
#'
#' @param cached a logical scalar. If TRUE, \code{cepespdata} will store the dataset inside your computes. Thus, if the same request is made, the data will be immediately available. Note that if you use this feature the app will create a sub-directory /static/cache of your working directory to store the downloaded data.
#'
#' @param columns_list a list with the columns needed. If supplied, \code{cepespdata} will return only the specified variables
#'
#' @param party Optional character with a specified party
#'
#' @param candidate_number Optional integer scalar
#'
#' @section Warning:
#'
#' \code{get_cepespdata()} is a function in development. Thus, merges performed by it remain
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
#' To limit the size of the data returned by the API, the request can be filtered to
#' return data on specific units: By state (using the two-letter abbreviation, eg. "RJ");
#' by party (using the two-digit official party number, eg. 45), or by candidate number.
#'
#' @section Cache:
#' Each time a request is made to the cepesp-R API, the specific dataset is constructed
#' and downloaded to your local system. To limit processing and bandwidth utilization,
#' the cepesp-R package includes the option to cache your requests so that they are stored
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
#' #Basic use of get_* functions.
#'
#' data <- get_cepespdata(year = 2014, position = "Deputado Federal", regional_aggregation = "UF")
#'

get_cepespdata <- function(year, position, regional_aggregation="Municipality", political_aggregation="Candidate", state="all", cached=FALSE, columns_list=list(), party=NULL, candidate_number=NULL) {
  regional_aggregation <- switch_regional_aggregation(regional_aggregation)
  political_aggregation <- switch_political_aggregation(political_aggregation)
  position <- switch_position(position)

  if (is.null(political_aggregation))
    stop('Unknown political_aggregation. Check if there is any mispelling error.')

  if (is.null(regional_aggregation))
    stop('Unknown regional_aggregation. Check if there is any mispelling error.')

  warning("[WARN] cepespdata function may return some invalid or incorrect results")
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

#' @rdname get_cepespdata
#' @export

get_votes <- function(year, position, regional_aggregation="Municipality", state="all", cached=FALSE, columns_list=list(), party=NULL, candidate_number=NULL) {
  prev_reg <- regional_aggregation
  regional_aggregation <- switch_regional_aggregation(regional_aggregation)
  position <- switch_position(position)

  if (is.null(regional_aggregation))
    stop('Unknown regional_aggregation. Check if there is any mispelling error.')

  if ((is.null(state) || state == "all") && regional_aggregation == 9)
    stop(paste('The "state" parameter is required when "regional_aggregation" is "', prev_reg, '"'))

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
      default_columns=columns_votes_sec(regional_aggregation)
    )
  )
}

#' @rdname get_cepespdata
#' @export

get_candidates <- function(year, position, cached=FALSE, columns_list=list(), party=NULL, candidate_number=NULL) {
  position <- switch_position(position)
  return (
    query(
      endpoint="candidatos",
      year=year,
      uf="all",
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

#' @rdname get_cepespdata
#' @export

get_coalitions <- function(year, position, cached=FALSE, columns_list=list(), party=NULL) {
  position <- switch_position(position)
  return (
    query(
      endpoint="legendas",
      year=year,
      uf="all",
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
