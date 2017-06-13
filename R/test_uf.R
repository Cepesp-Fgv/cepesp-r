

uf_list <- list("AC",
                "AL",
                "AM",
                "AP",
                "BA",
                "CE",
                "DF",
                "ES",
                "GO",
                "MA",
                "MG",
                "MS",
                "MT",
                "PA",
                "PB",
                "PE",
                "PI",
                "PR",
                "RJ",
                "RN",
                "RO",
                "RR",
                "RS",
                "SC",
                "SE",
                "SP",
                "TO",
                "ZZ")

test_uf <- function(uf){
  if(!uf %in% uf_list){
    stop(paste(c("UF's:",c(columns(regional_aggregation,political_aggregation))), collapse=', ' ))
  }
}
