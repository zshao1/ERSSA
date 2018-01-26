#' @title Calculate unique combinations of samples at varying replicate number
#'
#' @description
#' \code{comb_gen} function takes the list of samples in each condition
#' and calculate unique combination of sample names that allow
#' subsampling at varying replicate number.
#'
#' @details
#' At each replicate number, the total number of unique combination
#' of samples is computed. For example, 10 condition A samples subsampled
#' at replicate number of 2 has 45 unique combinations.
#'
#' When the total number of possible combinations at a particular
#' replicate number is more than the specified x number of
#' repetition (default=20), then only x unique combinations are selected.
#'
#' When the total number of possible combination is smaller than the
#' specified x number of repetitions, then only unique combinations
#' are selected. For example, 10 samples subsample for 9 replicates
#' has 10 unique combinations and only 10 combinations will be selected
#' instead of 20.
#'
#' This is repeated for both conditions and another level of combination
#' is performed to combine samples from the two conditions. Again, only
#' x number of unique combinations selected. When total unique combination
#' is smaller than x, then all unique combinations are selected.
#'
#' Selected combinations of samples at each replicate number are then
#' returned.
#'
#' @param condition_table A condition table with two columns and each sample as a row. Column 1 contains sample names and Column 2 contains sample condition e.g. Control, Treatment.
#' @param n_repetition The number of count tables to generate at each replicate number. DEFAULT = 20.
#'
#' @return A list of vector of sample combinations. Top list has names corresponding to each replicate number. Next, at each replicate number is a vector of unique combinations. Each combination is a single string with sample name separated by semicolon.
#'
#' @examples
#' comb_gen(condition_table, n_repetition=20)
#'
#' @export


comb_gen = function(condition_table, n_repetition=20){

  #rename input condition table column name
  colnames(condition_table) = c('sample_name','condition')

  #confirm only two conditions for comparison
  unique_conditions = unique(condition_table$condition)
  if (length(unique_conditions) != 2){
    stop('Only two conditions supported, e.g. Ctrl and Treatment.')
  }

  #confirm sample name does not contain semicolon
  sample_names = condition_table$sample_name
  contain_semic = sapply(sample_names, function(x) grepl(';', x))
  if (sum(contain_semic)>0){
    stop('Sample name cannot contain semicolon.')
  }

  #total replicates per condition and minimum of the two
  cond1_n = sum(condition_table$condition == unique_conditions[1])
  cond2_n = sum(condition_table$condition == unique_conditions[2])
  rep_min = min(c(cond1_n, cond2_n))

  #replicate series
  rep_series = seq(2, rep_min-1)

  #samples names associated with each condition
  cond1_name = as.character(condition_table$sample_name[which(condition_table$condition == unique_conditions[1])])
  cond2_name = as.character(condition_table$sample_name[which(condition_table$condition == unique_conditions[2])])
  min_sample_size = min(length(cond1_name),length(cond2_name))

  #master list with replicate as names with each contain vector of combinations. To be populated in the for loop below
  replicate_combs = list()

  #loop through replicate levels and generate combinations
  for (rep in seq(2, min_sample_size-1)){

    #generate unique combination of condition 1 samples at sepcified repetition
    #set repetition to smaller of two: n_repetition, n_combination
    comb_rep = n_repetition
    n_combination_cond1 = choose(length(cond1_name),rep)
    if (n_combination_cond1<n_repetition){
      comb_rep = n_combination_cond1
    }

    #generate comb_rep number of combinations for condition 1
    comb_cond1_list = c() #declare empty list to store combinations

    while (length(comb_cond1_list)!=comb_rep){
      comb_cond1 = sort(sample(cond1_name, rep)) #random samping without replacement
      comb_cond1_string = paste(as.character(comb_cond1), collapse=';') #collapse into one string

      if (!(comb_cond1_string %in% comb_cond1_list)) {
        comb_cond1_list = c(comb_cond1_list, comb_cond1_string) #add to combination list if string is unique
      }
    }

    #repeat for condition 2
    #set repetition to smaller of two: n_repetition, n_combination
    comb_rep = n_repetition
    n_combination_cond2 = choose(length(cond2_name),rep)
    if (n_combination_cond2<n_repetition){
      comb_rep = n_combination_cond2
    }

    #generate comb_rep number of combinations for condition 2
    comb_cond2_list = c() #declare empty list to store combinations

    while (length(comb_cond2_list)!=comb_rep){
      comb_cond2 = sort(sample(cond2_name, rep)) #random samping without replacement
      comb_cond2_string = paste(as.character(comb_cond2), collapse=';') #collapse into one string

      if (!(comb_cond2_string %in% comb_cond2_list)) {
        comb_cond2_list = c(comb_cond2_list, comb_cond2_string) #add to combination list if unique
      }
    }

    #generate combinations of condition 1 and 2
    comb_rep = n_repetition
    n_combination_merged = length(comb_cond1_list)*length(comb_cond2_list)
    if (n_combination_merged<n_repetition){
      comb_rep = n_combination_merged
    }

    #generate comb_rep number of combinations of condition 1 and 2
    comb_merged_list = c() #declare empty list to store combinations

    while (length(comb_merged_list)!=comb_rep){
      comb_merged = as.character(sample(comb_cond1_list, 1)) #random samping without replacement
      comb_merged = c(comb_merged, as.character(sample(comb_cond2_list,1)))
      comb_merged_string = paste(comb_merged, collapse=';') #collapse into one string

      if (!(comb_merged_string %in% comb_merged_list)) {
        comb_merged_list = c(comb_merged_list, comb_merged_string) #add to combination list if unique
      }
    }
    replicate_combs[[rep]]=comb_merged_list
  }


  return(replicate_combs)
}





