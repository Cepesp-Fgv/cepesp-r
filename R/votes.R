#' @export
cepespdata <- function(year=2014, state="all", regional_aggregation="Municipality", political_aggregation="Candidate", position="President", cached=FALSE, columns_list=list(), party=NULL, candidate_number=NULL) {
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

#' @export
votes <- function(year=2014, regional_aggregation="Municipality", position="President", cached=FALSE, columns_list=list(), state="all", party=NULL, candidate_number=NULL) {
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

#' @export
candidates <- function(year=2014, position="President", cached=FALSE, columns_list=list(), party=NULL, candidate_number=NULL) {
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

#' @export
coalitions <- function(year=2014, position="President", cached=FALSE, columns_list=list(), party=NULL) {
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
