#Instalar um de cada vez
#require(devtools)
#devtools::install_github('msperlin/GetDFPData')

if(!require('GetDFPData')) install.packages('GetDFPData',repos = "http://cran.us.r-project.org"); library(GetDFPData)
if(!require('dplyr')) install.packages('dplyr',repos = "http://cran.us.r-project.org"); library(dplyr)
if(!require('readxl')) install.packages('readxl',repos = "http://cran.us.r-project.org"); library(readxl)
if(!require('writexl')) install.packages('writexl',repos = "http://cran.us.r-project.org"); library(writexl)
if(!require('stringr')) install.packages('stringr',repos = "http://cran.us.r-project.org"); library(stringr)
if(!require('tidyverse')) install.packages('tidyverse',repos = "http://cran.us.r-project.org"); library(tidyverse)
if(!require('rstudioapi')) install.packages('rstudioapi',repos = "http://cran.us.r-project.org"); library(rstudioapi)
if(!require('corrplot')) install.packages('corrplot',repos = "http://cran.us.r-project.org"); library(corrplot)
require(magrittr)
library("dplyr")

rm(list = ls())
#minha_pasta deve conter  o caminho para a pasta onde esta o arquivo DFP a ser utilizado 
#minha_pasta <- "C:\\Users\\Theresa\\OneDrive\\Documentos\\CR Freelance"#lembrar de colocar o \\ ao inves de \
minha_pasta <- "C:\\Users\\Theresa\\Downloads"
setwd(minha_pasta)
# Lista os arquivos na pasta
lista <- list.files(pattern = "^GetDFP")

# Loop faz a leitura dos arquivos em RDS, e logo apos, faz a leitua interna do d, 
#que esta como list. Logo apos escreve o xlsx com o que está em cada nome da lista
for ( i in seq_along(lista))
{d <- readRDS(lista[i])#le o arquivo nativo do r, que vem pelo nome que está na lista
for(j in 1:length(d)){#Como o arquivo nativo no R retorna uma lista, andaremos pelo tamanho da lista
  
  path <- paste0(minha_pasta,"\\",names(d[j]),".xlsx") #cria o caminho onde sera colocado o arquivo no formato do excel
  
  if((class(d[[j]])== "data.frame")||(class(d[[j]])=="list")){
    for(k in 1: length(d[[j]])){
      if(!is.null(d[[j]][[k]])){#Alguns elementos da lista principal deram null, e estavam atrapalhando a analise. Esse pedaço vai deixar de analisa-los
        write_xlsx(d[[j]][[k]], path = path)
      }
    }
  }
}
}

