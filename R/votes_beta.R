votes_x_candidates <- function (year=2014, regional_aggregation="Municipality", position="President", cached=FALSE, columns_list=list(), state="AC", party=NULL, candidate_number=NULL) {
  candidates <- candidates(year, position, cached, list(), state, party, candidate_number)
  votes <- votes(year, regional_aggregation, position, cached, list(), party, candidate_number)

  result <- merge(votes, candidates, by="NUMERO_CANDIDATO", all.x = TRUE)
  return(result)
}
