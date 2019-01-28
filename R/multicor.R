##' Caculate the multiple correlation
##'
##' Caculate the multiple correlation of expression matrix. The matrix is
##' like this:
##'      sample1  sample2  sample3
##' gene1   xx      xx      xx
##' gene2   xx      xx      xx
##' gene3   xx      xx      xx
##' 
##' @param data expression matrix
##' @param method a character string indicating which correlation coefficient (or covariance) is to be computed.
##' @param rds RDS to save data
##' @param rewrite rewrite RDS
##' @param verbose log level
##' @return v1, v2, r, p.value, FDR
##' @export
##' @author Navy Cheng
multicor <- function(data, method= c('pearson', 'kendall', 'spearman'), rds=NA, rewrite=FALSE, verbose=TRUE) {
  if(!is.na(rds)) {
    if(file.exists(rds) && !rewrite) {
      message(paste('Load data from', rds))
      return(readRDS(rds))
    }
  }
  
  method <- match.arg(method)
  data <- as.matrix(data)
  r <- matrix(nrow=nrow(data),ncol=nrow(data))
  if (verbose) {
    message(paste('Calculating:', nrow(data),'rounds needed!'))
  }
  i <- 0
  p <- apply(data,1,function(x){
    i<<-i+1
    t0 <- Sys.time()
    if (verbose) {
      cat(paste0(i, ' '))
    }
    j<-0
    apply(data,1,function(y){
      j<<-j+1
      if (i > j) {
        test <- cor.test(x,y,method = method)
        r[j,i] <<- test$estimate
        test$p.value
      } else {
        NaN
      }
    })
  })
  if (verbose) {
    cat('\n')
  }
  dimnames(r) <- dimnames(p)
  list(r,p)
  r.melt <- reshape2::melt(r) %>% filter(!is.na(value))
  p.melt <- reshape2::melt(p) %>% filter(!is.na(value))
  ret <- data.frame(v1=r.melt$Var1, v2=r.melt$Var2, r=r.melt$value, p.value=p.melt$value, FDR=p.adjust(p.melt$value, method = 'BH'))
  if (!is.na(rds)) {
    saveRDS(ret, rds)
  }
  ret
}
