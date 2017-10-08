#Colunas Votação Seção [BETA]
columns <- function(regional_agregation=5, political_aggregation=2){

  columns = list()

  if (political_aggregation==1) {

    columns <- append(columns,list('ANO_ELEICAO',
                 'NUM_TURNO',
                 'DESCRICAO_ELEICAO',
                 'SIGLA_UE',
                 'DESCRICAO_UE',
                 'CODIGO_CARGO',
                 'DESCRICAO_CARGO',
                 'NUMERO_PARTIDO',
                 'SIGLA_PARTIDO',
                 'NOME_PARTIDO',
                 'QTDE_VOTOS'))
  } else if(political_aggregation==2) {
    columns <- append(columns,list('ANO_ELEICAO',
                  'NUM_TURNO',
                  'DESCRICAO_ELEICAO',
                  'SIGLA_UE',
                  'DESCRICAO_UE',
                  'CODIGO_CARGO',
                  'DESCRICAO_CARGO',
                  'NOME_CANDIDATO',
                  'SEQUENCIAL_CANDIDATO',
                  'NUMERO_CANDIDATO',
                  'CPF_CANDIDATO',
                  'NOME_URNA_CANDIDATO',
                  'COD_SITUACAO_CANDIDATURA',
                  'DES_SITUACAO_CANDIDATURA',
                  'NUMERO_PARTIDO',
                  'SIGLA_PARTIDO',
                  'NOME_PARTIDO',
                  'CODIGO_LEGENDA',
                  'SIGLA_LEGENDA',
                  'COMPOSICAO_LEGENDA',
                  'NOME_LEGENDA',
                  'CODIGO_OCUPACAO',
                  'DESCRICAO_OCUPACAO',
                  'DATA_NASCIMENTO',
                  'NUM_TITULO_ELEITORAL_CANDIDATO',
                  'IDADE_DATA_ELEICAO',
                  'CODIGO_SEXO',
                  'DESCRICAO_SEXO',
                  'COD_GRAU_INSTRUCAO',
                  'DESCRICAO_GRAU_INSTRUCAO',
                  'CODIGO_ESTADO_CIVIL',
                  'DESCRICAO_ESTADO_CIVIL',
                  'CODIGO_COR_RACA',
                  'DESCRICAO_COR_RACA',
                  'CODIGO_NACIONALIDADE',
                  'DESCRICAO_NACIONALIDADE',
                  'SIGLA_UF_NASCIMENTO',
                  'CODIGO_MUNICIPIO_NASCIMENTO',
                  'NOME_MUNICIPIO_NASCIMENTO',
                  'DESPESA_MAX_CAMPANHA',
                  'COD_SIT_TOT_TURNO',
                  'DESC_SIT_TOT_TURNO',
                  'NM_EMAIL',
                  'TIPO_LEGENDA',
                  'SIGLA_COLIGACAO',
                  'NOME_COLIGACAO',
                  'COMPOSICAO_COLIGACAO',
                  'SEQUENCIA_COLIGACAO',
                  'QTDE_VOTOS'))

  } else if(political_aggregation==3) {

    columns <- append(columns,list('ANO_ELEICAO',
                  'NUM_TURNO',
                  'DESCRICAO_ELEICAO',
                  'SIGLA_UE',
                  'DESCRICAO_UE',
                  'CODIGO_CARGO',
                  'DESCRICAO_CARGO',
                  'SIGLA_COLIGACAO',
                  'NOME_COLIGACAO',
                  'COMPOSICAO_COLIGACAO',
                  'SEQUENCIA_COLIGACAO'))
  } else {

    columns <- append(columns,
                      list('ANO_ELEICAO',
                  'NUM_TURNO',
                  'DESCRICAO_ELEICAO',
                  'CODIGO_CARGO',
                  'DESCRICAO_CARGO',
                  'QTD_APTOS',
                  'QTD_COMPARECIMENTO',
                  'QTD_ABSTENCOES',
                  'QT_VOTOS_NOMINAIS',
                  'QT_VOTOS_BRANCOS',
                  'QT_VOTOS_NULOS',
                  'QT_VOTOS_LEGENDA',
                  'QT_VOTOS_ANULADOS_APU_SEP'
                      ))
  }


  if (regional_agregation==1) {
    columns <- c(columns,list('CODIGO_MACRO',
                  'NOME_MACRO'))
  } else if (regional_agregation==2) {
    columns <- c(columns,list('CODIGO_MACRO',
                  'NOME_MACRO',
                  'UF',
                  'NOME_UF'))
  } else if(regional_agregation==4) {
    columns <- c(columns,list('CODIGO_MACRO',
                 'NOME_MACRO',
                 'UF',
                 'NOME_UF',
                 'CODIGO_MESO',
                 'NOME_MESO',
                 'CODIGO_MICRO'))
  } else if(regional_agregation==5) {
    columns <- append(columns,list('CODIGO_MACRO',
                 'NOME_MACRO',
                 'UF',
                 'NOME_UF',
                 'CODIGO_MESO',
                 'NOME_MESO',
                 'CODIGO_MICRO',
                 'NOME_MICRO'))
  } else if(regional_agregation==6) {
    columns <- c(columns,list('CODIGO_MACRO',
                 'NOME_MACRO',
                 'UF',
                 'NOME_UF',
                 'CODIGO_MESO',
                 'NOME_MESO',
                 'CODIGO_MICRO',
                 'NOME_MICRO',
                 'COD_MUN_TSE',
                 'COD_MUN_IBGE',
                 'NOME_MUNICIPIO'))
  } else if(regional_agregation==7) {
    columns <- c(columns,list('CODIGO_MACRO',
                 'NOME_MACRO',
                 'UF',
                 'NOME_UF',
                 'CODIGO_MESO',
                 'NOME_MESO',
                 'CODIGO_MICRO',
                 'NOME_MICRO',
                 'COD_MUN_TSE',
                 'COD_MUN_IBGE',
                 'NOME_MUNICIPIO',
                 'NUM_ZONA'))
  } else {
    columns <- append(columns,list('CODIGO_MACRO',
                 'NOME_MACRO',
                 'UF',
                 'NOME_UF',
                 'CODIGO_MESO',
                 'NOME_MESO',
                 'CODIGO_MICRO',
                 'NOME_MICRO',
                 'NUM_ZONA'))
  }

  return(columns)
}


#Colunas Votação Seção
columns_votes_sec <- function(regional_agregation=5) {

  columns = list(
    'DATA_GERACAO',
    'HORA_GERACAO',
    'ANO_ELEICAO',
    'SIGLA_UE',
    'NUM_TURNO',
    'DESCRICAO_ELEICAO',
    'CODIGO_CARGO',
    'DESCRICAO_CARGO',
    'NUMERO_CANDIDATO',
    'QTDE_VOTOS'
  )

  if (regional_agregation==1) {
    columns <- append(columns, list(
      'CODIGO_MACRO',
      'NOME_MACRO'
   ))
  } else if (regional_agregation==2) {
    columns <- append(columns, list(
      'CODIGO_MACRO',
      'NOME_MACRO',
      'UF',
      'NOME_UF'
    ))
  } else if(regional_agregation==4) {
    columns <- append(columns, list(
      'CODIGO_MACRO',
      'NOME_MACRO',
      'UF',
      'NOME_UF',
      'CODIGO_MESO',
      'NOME_MESO',
      'CODIGO_MICRO'
    ))
  } else if(regional_agregation==5) {
    columns <- append(columns, list(
      'CODIGO_MACRO',
      'NOME_MACRO',
      'UF',
      'NOME_UF',
      'CODIGO_MESO',
      'NOME_MESO',
      'CODIGO_MICRO',
      'NOME_MICRO'
    ))
  } else if(regional_agregation==6) {
    columns <- append(columns, list(
      'CODIGO_MACRO',
      'NOME_MACRO',
      'UF',
      'NOME_UF',
      'CODIGO_MESO',
      'NOME_MESO',
      'CODIGO_MICRO',
      'NOME_MICRO',
      'COD_MUN_TSE',
      'COD_MUN_IBGE',
      'NOME_MUNICIPIO'
    ))
  } else if(regional_agregation==7) {
    columns <- append(columns, list(
      'CODIGO_MACRO',
      'NOME_MACRO',
      'UF',
      'NOME_UF',
      'CODIGO_MESO',
      'NOME_MESO',
      'CODIGO_MICRO',
      'NOME_MICRO',
      'COD_MUN_TSE',
      'COD_MUN_IBGE',
      'NOME_MUNICIPIO',
      'NUM_ZONA'
    ))
  } else {
    columns <- append(columns, list(
      'CODIGO_MACRO',
      'NOME_MACRO',
      'UF',
      'NOME_UF',
      'CODIGO_MESO',
      'NOME_MESO',
      'CODIGO_MICRO',
      'NOME_MICRO',
      'NUM_ZONA'
    ))
  }

  return(columns)
}

#Colunas Candidatos
columns_candidates <- function() {

  return(list(
    'DATA_GERACAO',
    'HORA_GERACAO',
    'ANO_ELEICAO',
    'NUM_TURNO',
    'DESCRICAO_ELEICAO',
    'SIGLA_UF',
    'SIGLA_UE',
    'DESCRICAO_UE',
    'CODIGO_CARGO',
    'DESCRICAO_CARGO',
    'NOME_CANDIDATO',
    'NUMERO_CANDIDATO',
    'CPF_CANDIDATO',
    'NOME_URNA_CANDIDATO',
    'COD_SITUACAO_CANDIDATURA',
    'DES_SITUACAO_CANDIDATURA',
    'NUMERO_PARTIDO',
    'SIGLA_PARTIDO',
    'NOME_PARTIDO',
    'CODIGO_LEGENDA',
    'SIGLA_LEGENDA',
    'COMPOSICAO_LEGENDA',
    'NOME_COLIGACAO',
    'CODIGO_OCUPACAO',
    'DESCRICAO_OCUPACAO',
    'DATA_NASCIMENTO',
    'NUM_TITULO_ELEITORAL_CANDIDATO',
    'IDADE_DATA_ELEICAO',
    'CODIGO_SEXO',
    'DESCRICAO_SEXO',
    'COD_GRAU_INSTRUCAO',
    'DESCRICAO_GRAU_INSTRUCAO',
    'CODIGO_ESTADO_CIVIL',
    'DESCRICAO_ESTADO_CIVIL',
    'CODIGO_COR_RACA',
    'DESCRICAO_COR_RACA',
    'CODIGO_NACIONALIDADE',
    'DESCRICAO_NACIONALIDADE',
    'SIGLA_UF_NASCIMENTO',
    'CODIGO_MUNICIPIO_NASCIMENTO',
    'NOME_MUNICIPIO_NASCIMENTO',
    'DESPESA_MAX_CAMPANHA',
    'COD_SIT_TOT_TURNO',
    'DESC_SIT_TOT_TURNO',
    'EMAIL_CANDIDATO'
  ))

}

#Colunas Legendas
columns_political_parties <- function() {

  return(list(
    'DATA_GERACAO',
    'HORA_GERACAO',
    'ANO_ELEICAO',
    'NUM_TURNO',
    'DESCRICAO_ELEICAO',
    'SIGLA_UF',
    'SIGLA_UE',
    'CODIGO_CARGO',
    'DESCRICAO_CARGO',
    'TIPO_LEGENDA',
    'NUMERO_PARTIDO',
    'SIGLA_PARTIDO',
    'NOME_PARTIDO',
    'SIGLA_COLIGACAO',
    'NOME_COLIGACAO',
    'COMPOSICAO_COLIGACAO',
    'SEQUENCIAL_COLIGACAO'
  ))

}
