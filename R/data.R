#' The RNA-seq counts data from TCGA-PRAD project
#'
#' The counts data contain 551 samples with 499 tumor and 52 normal tissue.
#' The first 499 column is tumor tissue and the other 52 columns is nuormal tissue.
#'
#' @format A data frame with 60483 rows and 551 samples.
#' @usage data("prad.rna.count")

"prad.rna.count"


#' TF-targets dataset
#'
#' Get motif from Jaspar core database and scan the promoter region with fimo
#'
#' @format A data frame wth 'tf' and 'gene'
#' @usage data("tf2gene.jaspar")
"tf2gene.jaspar"

#' TF-targets dataset
#'
#' Use MetaCluster data of GTRD
#'
#' @format A data frame wth 'tf' and 'gene'
#' @usage data("tf2gene.gtrd")
"tf2gene.trrust"

#' TF-targets dataset
#'
#' Dataset from TRRUST
#'
#' @format A data frame wth 'tf' and 'gene'
#' @usage data("tf2gene.trrust")
"tf2gene.gtrd"

