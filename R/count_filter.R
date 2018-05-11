#' @title Filter RNA-seq expression table
#'
#' @description
#' \code{count_filter} function filters the RNA-seq count table to remove
#' non- and low-expression genes at an defined average CPM cutoff (Default=1).
#'
#' @details
#' The filtered count table is saved to the drive in a file named
#' "filtered_counts.csv".
#'
#' @param count_table A RNA-seq count matrix with genes on each row and samples
#' on each column.
#' @param cutoff Any gene with average CPM below this cutoff value will be
#' filtered out.
#' @param path Path to save the filtered count table
#'
#' @return The filtered count table.
#'
#' @author Zixuan Shao, \email{Zixuanshao.zach@@gmail.com}
#'
#' @examples
#' #load simple GTeX example count table
#' #test dataset with 1000 genes, 4 replicates and 20 comb. per rep. level
#' data(count_table.partial, package = "ERSSA")
#'
#' #filter the counts
#' count_table.filtered.partial = count_filter(count_table.partial)
#'
#' @export


count_filter = function(count_table=NULL, cutoff=1, path='.'){

  #check all required arguments supplied
  if (is.null(count_table)){
    stop('Missing required count_table argument in count_filter function')
  } else if (!(is.data.frame(count_table))){
    stop('count_table is not an expected data.frame object')
  } else if (length(unique(sapply(count_table, class)))!=1){
    stop(paste0('More than one data type detected in count table, please make ',
                'sure count table contains only numbers and that the list of ',
                'gene names is the data.frame index'))
  }

  cpm_table = t(t(count_table)*1000000/colSums(count_table))
  count_table_filtered = count_table[which(rowMeans(cpm_table)>cutoff),]

  #create dir to save results
  folder_path = file.path(path)
  dir.create(folder_path, showWarnings = FALSE)

  #save the filtered counts
  utils::write.csv(count_table_filtered, file.path(path,'filtered_counts.csv'))
  return(count_table_filtered)
}
