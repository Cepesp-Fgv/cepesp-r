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


url <- "http://127.0.0.1:5000/api/consulta/tse"


vote <- function(year=2014, uf="SE", regional_aggregation=5,political_aggregation=2, position=1,cached=FALSE, columns_list=list()) {

  if(length(columns_list) == 0) {
    columns_list <- columns(regional_aggregation,political_aggregation)
  }else{
    test_columns(regional_aggregation,political_aggregation,columns_list)
  }
  names(columns_list) <- rep("selected_columns[]",length(columns_list))
  consulta <- append(list(anos=year,agregacao_regional=regional_aggregation,agregacao_politica=political_aggregation,cargo=position),columns_list)
  resp <- GET(url, query=consulta)

  return(content(resp))
}
