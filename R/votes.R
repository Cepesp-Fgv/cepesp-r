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


url <- "http://api.cepesp.io/api/consulta/tse"


votes <- function(year=2014, uf="all", regional_aggregation=5,political_aggregation=2, position=1,cached=FALSE, columns_list=list()) {

  if(length(columns_list) == 0) {
    columns_list <- columns(regional_aggregation,political_aggregation)
  }else{
    test_columns(regional_aggregation,political_aggregation,columns_list)
  }
  names(columns_list) <- rep("selected_columns[]",length(columns_list))
  consulta <- append(list(anos=year,agregacao_regional=regional_aggregation,agregacao_politica=political_aggregation,cargo=position),columns_list)
  if (uf!="all"){
    test_uf(uf)
    filter <- list("columns[0][name]"="UF","columns[0][search][value]"=uf)
    consulta = append(consulta,filter)
  }
  resp <- GET(url, query=consulta)

  return(content(resp))
}
