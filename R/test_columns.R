test_columns <- function(regional_aggregation,political_aggregation,columns_list){
  for(name in columns_list){
    if(name %in% columns(regional_aggregation,political_aggregation)){
    }
    else{
      stop(paste(c("Existent columns:",c(columns(regional_aggregation,political_aggregation))), collapse=', ' ))
    }
  }
  if(!"QTDE_VOTOS" %in% columns_list){
    stop("QTDE_VOTOS column is required")
  }
}
