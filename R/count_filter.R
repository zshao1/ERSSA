#' @title Filter RNA-seq expression table
#'
#' @description
#' \code{count_filter} Function filters the RNA-seq count table to remove
#' low expression genes at an user-defined averaged count cutoff 
#' (Default=10).
#'
#' 
#' @param count_table Input RNA-seq count table.
#' @param cutoff Any gene with average count below this number will be filtered.
#' 
#' @return The filtered count table is returned.
#' 
#' @examples
#' \dontrun{count_filter(count_table, cutoff=10)}
#' 
#' @export


count_filter = function(count_table, cutoff=10){
  
count_table_filtered = count_table[which(rowMeans(count_table)>cutoff),]
return(count_table_filtered)
}
