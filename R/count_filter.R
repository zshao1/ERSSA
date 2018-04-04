#' @title Filter RNA-seq expression table
#'
#' @description
#' \code{count_filter} function filters the RNA-seq count table to remove
#' low expression genes at an defined average CPM cutoff
#' (Default=1).
#'
#'
#' @param count_table Input RNA-seq count table.
#' @param cutoff Any gene with average CPM below this cutoff value will be filtered out.
#'
#' @return The filtered count table is returned.
#'
#' @examples
#' count_table.filtered = count_filter(count_table, cutoff=1)
#'
#' @export


count_filter = function(count_table, cutoff=1){

  cpm_table = t(t(count_table)*1000000/colSums(count_table))
  count_table_filtered = count_table[which(rowMeans(cpm_table)>cutoff),]
  return(count_table_filtered)
}
