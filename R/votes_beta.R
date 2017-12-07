votes_x_candidates <- function (year=2014, regional_aggregation="Municipality", position="President", cached=FALSE, state="all", party=NULL, candidate_number=NULL) {

  warning("[WARN] votes_x_candidates function may return some invalid or incorrect results")

  candidates <- candidates(
    year=year,
    position=position,
    cached=cached,
    party=party,
    candidate_number=candidate_number
  )

  votes <- votes(
    year=year,
    regional_aggregation=regional_aggregation,
    position=position,
    cached=cached,
    state=state,
    party=party,
    candidate_number=candidate_number
  )

  if (switch_position(position) == 1) {
    keys <- c("NUMERO_CANDIDATO", "ANO_ELEICAO", "CODIGO_CARGO", "DESCRICAO_CARGO", "NUM_TURNO")
  } else {
    keys <- c("SIGLA_UE", "NUMERO_CANDIDATO", "ANO_ELEICAO", "CODIGO_CARGO", "DESCRICAO_CARGO", "NUM_TURNO")
  }

  result <- merge(x = votes, y = candidates, by=keys, all.x = TRUE)
  return(result)
}
