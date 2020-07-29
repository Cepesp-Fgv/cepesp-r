#Colunas Votação Seção [BETA]
columns <- function(regional_aggregation=5, political_aggregation=2){

  columns = list()

  if (political_aggregation==1) {

    columns <- append(columns, list(
      'ANO_ELEICAO',
      'NUM_TURNO',
      'DESCRICAO_ELEICAO',
      'SIGLA_UE',
      'CODIGO_CARGO',
      'DESCRICAO_CARGO',
      'NUMERO_PARTIDO',
      'SIGLA_PARTIDO',
      'NOME_PARTIDO',
      'QTDE_VOTOS'
    ))

  } else if(political_aggregation==2) {

    columns <- append(columns, list(
      'ANO_ELEICAO',
      'NUM_TURNO',
      'DESCRICAO_ELEICAO',
      'SIGLA_UE',
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
      'COD_MUN_TSE_NASCIMENTO',
      'NOME_MUNICIPIO_NASCIMENTO',
      'DESPESA_MAX_CAMPANHA',
      'COD_SIT_TOT_TURNO',
      'DESC_SIT_TOT_TURNO',
      'NM_EMAIL',
      'TIPO_LEGENDA',
      'SIGLA_COLIGACAO',
      'NOME_COLIGACAO',
      'COMPOSICAO_COLIGACAO',
      'QTDE_VOTOS'
    ))

  } else if(political_aggregation==3) {

    columns <- append(columns, list(
      'ANO_ELEICAO',
      'NUM_TURNO',
      'DESCRICAO_ELEICAO',
      'SIGLA_UE',
      'CODIGO_CARGO',
      'DESCRICAO_CARGO',
      'SIGLA_COLIGACAO',
      'NOME_COLIGACAO',
      'COMPOSICAO_COLIGACAO',
      'SEQUENCIA_COLIGACAO'
    ))

  } else {

    columns <- append(columns, list(
      'ANO_ELEICAO',
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


  if (regional_aggregation==1) {
    columns <- c(columns, list('CODIGO_MACRO', 'NOME_MACRO'))
  } else if (regional_aggregation==2) {
    columns <- c(columns, list(
      'CODIGO_MACRO',
      'NOME_MACRO',
      'UF',
      'NOME_UF'
    ))
  } else if(regional_aggregation==4) {
    columns <- c(columns, list(
      'CODIGO_MACRO',
      'NOME_MACRO',
      'UF',
      'NOME_UF',
      'CODIGO_MESO',
      'NOME_MESO'
    ))
  } else if(regional_aggregation==5) {
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
  } else if(regional_aggregation == 6) {
    columns <- c(columns, list(
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
  } else if(regional_aggregation==7) {
    columns <- c(columns, list(
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
  } else if (regional_aggregation==8) {
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
  } else if (regional_aggregation==9) {
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
      'NUM_ZONA',
      'NUM_SECAO'
    ))
  }

  return(columns)
}


#Colunas Votação Seção
columns_votes_sec <- function(regional_aggregation=5) {

  columns = list(
    'ANO_ELEICAO',
    'SIGLA_UE',
    'NUM_TURNO',
    'DESCRICAO_ELEICAO',
    'CODIGO_CARGO',
    'DESCRICAO_CARGO',
    'NUMERO_CANDIDATO',
    'QTDE_VOTOS'
  )

  if (regional_aggregation==1) {
    columns <- append(columns, list(
      'CODIGO_MACRO',
      'NOME_MACRO'
    ))
  } else if (regional_aggregation==2) {
    columns <- append(columns, list(
      'CODIGO_MACRO',
      'NOME_MACRO',
      'UF',
      'NOME_UF'
    ))
  } else if(regional_aggregation==4) {
    columns <- append(columns, list(
      'CODIGO_MACRO',
      'NOME_MACRO',
      'UF',
      'NOME_UF',
      'CODIGO_MESO',
      'NOME_MESO'
    ))
  } else if(regional_aggregation==5) {
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
  } else if(regional_aggregation==6) {
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
  } else if(regional_aggregation==7) {
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
  } else if(regional_aggregation==8) {
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
  } else if (regional_aggregation==9) {
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
      'NUM_ZONA',
      'NUM_SECAO'
    ))
  } else if (regional_aggregation==10) {
    columns <- append(columns, list(
      'ANO_ELEICAO',
      'NUM_ZONA',
      'CODIGO_MICRO',
      'NOME_MICRO',
      'CODIGO_MESO',
      'NOME_MESO',
      'UF',
      'NOME_UF',
      'CODIGO_MACRO',
      'NOME_MACRO',
      'COD_MUN_TSE',
      'COD_MUN_IBGE',
      'NOME_MUNICIPIO',
      'NUM_TURNO',
      'DESCRICAO_ELEICAO',
      'SIGLA_UE',
      'CODIGO_CARGO',
      'DESCRICAO_CARGO',
      'NUMERO_CANDIDATO',
      
      'NOME_LOCAL_VOTACAO',
      'NUM_LOCAL_VOTACAO',
      'DESCRICAO_ENDERECO',
      'DESCRICAO_BAIRRO',
      'NUM_CEP',
      'NOME_LOCALIDADE',
      
      'QTDE_VOTOS'
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
    'CODIGO_NACIONALIDADE',
    'DESCRICAO_NACIONALIDADE',
    'SIGLA_UF_NASCIMENTO',
    'CODIGO_MUNICIPIO_NASCIMENTO',
    'NOME_MUNICIPIO_NASCIMENTO',
    'DESPESA_MAX_CAMPANHA',
    'COD_SIT_TOT_TURNO',
    'DESC_SIT_TOT_TURNO'
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
    'SEQUENCIA_COLIGACAO'
  ))

}

#Colunas Bens Candidatos
columns_bens_candidatos <- function() {

  return(list(
    'DATA_GERACAO',
    'HORA_GERACAO',
    'ANO_ELEICAO',
    'DESCRICAO_ELEICAO',
    'SIGLA_UF',
    'SEQUENCIAL_CANDIDATO',
    'CD_TIPO_BEM_CANDIDATO',
    'DS_TIPO_BEM_CANDIDATO',
    'DETALHE_BEM',
    'VALOR_BEM',
    'DATA_ULTIMA_ATUALIZACAO',
    'HORA_ULTIMA_ATUALIZACAO',
    'ID_CANDIDATO',
    'SIGLA_UE',
    'DESCRICAO_UE',
    'CODIGO_CARGO',
    'DESCRICAO_CARGO',
    'NUMERO_PARTIDO',
    'SIGLA_PARTIDO',
    'NOME_CANDIDATO',
    'NUMERO_CANDIDATO',
    'CPF_CANDIDATO',
    'NOME_URNA_CANDIDATO',
    'COD_SITUACAO_CANDIDATURA',
    'DES_SITUACAO_CANDIDATURA',
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
    'EMAIL_CANDIDATO'
  ))

}

columns_secretaries <- function() {

  return(list(
    'STATUS',
    'NOME_SECRETARIO',
    'RG',
    'SEXO',
    'NOME_MUNICIPIO_NASCIMENTO',
    'UF_NASCIMENTO',
    'CARGO',
    'ORGAO_OCUPADO',
    'UF_ORGAO_OCUPADO',
    'COD_GRAU_INSTRUCAO',
    'DESCRICAO_GRAU_INSTRUCAO',
    'CURSO_MESTRADO',
    'CURSO_DOUTORADO',
    'JA_ERA_FUNCIONARIO_PUBLICO',
    'NIVEL_DE_GOVERNO',
    'TRABALHAVA_NA_SECRETARIA_NO_MOMENTO_DA_NOMEACAO',
    'ORGAO_EM_QUE_TRABALHAVA',
    'ANO_INGRESSO_ORGAO',
    'MES_INGRESSO_ORGAO',
    'PROFISSAO_ANTES_DE_NOMEADO',
    'UF',
    'ID_SECRETARIO',
    'CPF',
    'TITULO_DE_ELEITOR',
    'ORGAO_NOME',
    'ID_CARGO',
    'ID_ORGAO',
    'DATA_ASSUMIU',
    'DATA_DEIXOU',
    'MOTIVO_SAIDA',
    'ORIGEM_FILIACAO',
    'SIGLA_PARTIDO',
    'NOME_PARTIDO',
    'CODIGO_MUNICIPIO',
    'NOME_MUNICIPIO',
    'RACA_RAIS',
    'DATA_NASCIMENTO'
  ))

}

columns_filiates <- function() {

  return(list(
    'DATA_EXTRACAO',
    'HORA_EXTRACAO',
    'NUMERO_INSCRICAO',
    'NOME_FILIADO',
    'SIGLA_PARTIDO',
    'NOME_PARTIDO',
    'UF',
    'COD_MUN_TSE',
    'NOME_MUNICIPIO',
    'NUM_ZONA',
    'NUM_SECAO',
    'DATA_FILIACAO',
    'SITUACAO_REGISTRO',
    'TIPO_REGISTRO',
    'DATA_PROCESSAMENTO',
    'DATA_DESFILIACAO',
    'DATA_CANCELAMENTO',
    'DATA_REGULARIZACAO',
    'MOTIVO_CANCELAMENTO'
  ))

}

