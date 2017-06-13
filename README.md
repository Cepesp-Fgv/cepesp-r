# cepesp-r


### Instalação

``` {.r}
if (!require("devtools")) install.packages("devtools")
devtools::install_github("Cepesp-Fgv/cepesp-r")
```

### Como funciona

``` {.r}
library(cepespR)
df <- votes(year = 2014,regional_agregation=3, political_aggregation=2, position=1)

```


| Agregação Regional        | Número |
| ------------------------- |:------:|
| Brasil                    |   0    |
| Macro Região.             |   1    |
| UF                        |   2    | 
| Meso  Região.             |   4    | 
| Micro Região.             |   5    | 
| Municipio                 |   6    | 
| Município - Zona Eleitoral|   7    | 
| Zona Eleitoral            |   8    | 



| Agregação Política        | Número |
| ------------------------- |:------:|
| Partido                   |   1    |
| Candidato                 |   2    | 
| Coligação                 |   3    | 
| Consolidado da Eleição    |   4    |



| Cargo(position)      | Número |
| ------------------------- |:------:|
| Presidente                |   1    |
| Governador                |   3    | 
| Senador                   |   5    |
| Deputado Federal          |   6    | 
| Deputado Estadual         |   7    | 
| Prefeito                  |   11   |
| Vereador                  |   13   |

