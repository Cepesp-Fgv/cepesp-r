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

vote <- function(year=2014, uf="all", regional_aggregation=5,political_aggregation=2, position=1,cached=FALSE) {

  url <- "http://api.cepesp.io/api/consulta/tse"

  vars <- list("UF","ANO_ELEICAO","CODIGO_MUNICIPIO","NOME_MUNICIPIO","NOME_URNA_CANDIDATO","NUMERO_CANDIDATO","NUMERO_PARTIDO","SIGLA_PARTIDO","DESC_SIT_TOT_TURNO","QTDE_VOTOS")
  names(vars) <- rep("selected_columns[]",length(vars))
  filter <- list("columns[0][name]"="UF","columns[0][search][value]"=uf)

  consulta <- append(append(list(anos=year,agregacao_regional=regional_aggregation,agregacao_politica=political_aggregation,cargo=position),vars),filter)
  resp <- GET(url, query=consulta, cache=cached)

  return(content(resp))
}
