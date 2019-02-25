# CEPESP R

CepespR is a simple package designed to assist users to access the API to [Cepespdata](http://cepesp.io), which facilitates rapid, cleaned, organized and documented access to the [Tribunal Superior Eleitoral's](http://www.tse.jus.br/eleicoes/estatisticas/repositorio-de-dados-eleitorais) data on elections in Brazil from 1998 to 2018.  

## About the CEPESPdata internal API
This R project comunicates with our CEPESPdata API. All the data within this application was extracted from the official TSE repository. After the extraction, the data files were post-processed and organized using HiveQL and Pandas (Python library). There is also an internal cache to minimize the response time of all pre-made requests.

### Installation

To install cepesp-R from its [Github repository](https://github.com/Cepesp-Fgv/cepesp-r), open R/RStudio and type the following:


``` {.r}
if (!require("devtools")) install.packages("devtools")
devtools::install_github("Cepesp-Fgv/cepesp-r")
library(cepespR)
```

### Core Functionality

After loading the cepesp-R package into your R session there are four functions which retrieve alternative slices of the processed TSE data. Each which will return a data.frame of the requested election details. The following get_* functions don't provide default values for __year__ and __position__. The four functions are:

1. `get_votes` - Details about the number of votes won by each candidate in a specific election. Just specify the position and year of the electoral contest you want data for, and the regional level at which you would like votes to be aggregated. For example, should Presidential election results be returned as national totals for all of Brazil, or separately for each municipality?

``` {.r}
get_votes(year=2014, position="President", regional_aggregation="Municipality")
```

2. `get_candidates` - Details about the characteristics of individual candidates competing in an election. Just specify the position and year for which you want data. It's also possible to filter the dataframe in order to return only the data concerning elected candidates using the option only_elected = TRUE (default option is only_elected = FALSE).

``` {.r}
get_candidates(year=2014, position="President")
```


3. `get_coalitions` - Details about the parties that constitute each coalition that competed in each election. Just specify the position and year for which you want data.

``` {.r}
get_coalitions(year=2014, position="President")
```

4. `get_elections` - The most comprehensive function which merges data on election results, candidates and coalitions to enable more complex analysis. However, the merges performed here remain imperfect due to errors in the underlying TSE data and so this function should be treated as beta and used with caution. Specify the position and year for which you want data, the regional aggregation at which votes should be summed, and the political aggregation at which votes should be disaggregated - by individual candidates, parties, coalitions, or as totals for each electoral unit. The parameter only-elected is also available for this function (see #2 get_candidates).

``` {.r}
get_elections(year=2014, position="President", regional_aggregation="Municipality", political_aggregation="Candidate")
```

The structure of the resulting data.frame has one row for each unit of regional aggregation and for each unit of political aggregation (for example, for each candidate in each municipality or each party in each state).

### Parameters

The table below highlights the available options for each required parameter:

| year        | position        | regional_aggregation  | political_aggregation |
| ----------- |-----------------| ----------------------| ----------------------|
| 1998        | Councillor      | Brazil                | Candidate             |
| 2000        | Mayor           | Macro                 | Party                 |
| 2002        | State Deputy    | State                 | Coalition             |
| 2004        | Federal Deputy  | Meso                  | Consolidated          |
| 2006        | Senator         | Micro                 |                       |
| 2008        | Governor        | Municipality          |                       |
| 2010        | President       | Municipality-Zone     |                       |
| 2012        |                 | Zone                  |                       |
| 2014        |                 | Electoral Section     |                       |
| 2016        |                 |                       |                       |

The same parameters can also be entered in Portuguese:

| year        | position        | regional_aggregation  | political_aggregation |
| ----------- |-----------------| ----------------------| ----------------------|
| 1998        | Vereador      | Brasil                | Candidato             |
| 2000        | Prefeito          | Macro                 | Partido                 |
| 2002        | Deputado Estadual    | Estado                 | Coligacao             |
| 2004        | Deputado Federal  | Meso                  | Consolidado          |
| 2006        | Senador         | Micro                 |                       |
| 2008        | Governador        | Municipio          |                       |
| 2010        | Presidente       | Municipio-Zona     |                       |
| 2012        |                 | Zona                  |                       |
| 2014        |                 | Votação Seção         |                       |
| 2016        |                 |                       |                       |

Not all electoral contests occur in every year. Feasible requests are:

| Ano      | Cargos Disponíveis (Descrição) | 
| ------------------------- |:------|
| 1998                |   Presidente, Governador, Senador, Deputado Federal, Deputado Estadual, Deputado Distrital   | 
| 2000                |   Prefeito, Vereador    | 
| 2002                |   Presidente, Governador, Senador, Deputado Federal, Deputado Estadual, Deputado Distrital    |
| 2004                |   Prefeito, Vereador    | 
| 2006                |   Presidente, Governador, Senador, Deputado Federal, Deputado Estadual, Deputado Distrital    |
| 2008                |   Prefeito, Vereador    | 
| 2010                |   Presidente, Governador, Senador, Deputado Federal, Deputado Estadual, Deputado Distrital    | 
| 2012                |   Prefeito, Vereador    | 
| 2014                |   Presidente, Governador, Senador, Deputado Federal, Deputado Estadual, Deputado Distrital    | 
| 2016                |   Prefeito, Vereador    | 



### Selecting Variables
The default setting is for the function to return all the available variables (columns). To select specific variables and limit the size of the request, you can specify a list of required columns in the `columns_list` property. The specific columns available depend on the political and regional aggregation selected so you are advised to refer to the API documentation at https://github.com/Cepesp-Fgv/cepesp-rest for further details. 

Example:
```{r}
columns <- list("NUMERO_CANDIDATO","UF","QTDE_VOTOS","COD_MUN_IBGE")

data <- get_votes(year = 2014, position=1, regional_aggregation="Municipality", columns_list=columns)
```

### Filters
To limit the size of the data returned by the API, the request can be filtered to return data on specific units: By state (using the two-letter abbreviation, eg. "RJ"); by party (using the two-digit official party number, eg. 45), or by candidate number.

For example:
```{r}
data <- get_elections(year = 2014, position=1, regional_aggregation=2, political_aggregation=2, state="RS") #To select Rio Grande do Sul 

data <- get_elections(year = 2014, position=1, regional_aggregation=2, political_aggregation=2, party=13) #To select the PT (=13)

data <- get_elections(year = 2014, position=1, regional_aggregation=2, political_aggregation=2, candidate=2511) #To select candidate 2511
```
**Important:** When requesting data with `regional_aggregation=9`, the filter `state` should not be `NULL`

### Cache
Each time a request is made to the cepesp-R API, the specific dataset is constructed and downloaded to your local system. To limit processing and bandwidth utilization, the cepesp-R package includes the option to cache your requests so that they are stored locally and immediately available when that request is repeated. 

Note that if you use this feature the app will create a sub-directory `/static/cache` of your working directory to store the downloaded data. You can manually delete this data to force a new download the next time the same request is made. 

```{r, eval=FALSE}
data <- get_votes(year = 2014, position=1, regional_aggregation="Municipality", cached=TRUE)
```


