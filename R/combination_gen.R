#' @title Calculate unique combinations of samples at varying replicate number
#'
#' @description
#' \code{comb_gen} function takes the list of samples in each condition
#' and generate unique combination of sample names that allow
#' subsampling at varying replicate numbers.
#'
#' @details
#' At each replicate number (2 to N-1), the total number of unique combination
#' of samples is computed. For example, 10 condition A samples subsampled
#' at replicate number of 2 has 45 unique combinations.
#'
#' When the total number of possible combinations at a particular
#' replicate number is more than the specified x number of
#' repetition (default=30), then only x unique combinations are selected.
#'
#' When the total number of possible combination is smaller than the
#' specified x number of repetitions, then only unique combinations
#' are selected. For example, 10 samples subsample for 9 replicates
#' has 10 unique combinations and only 10 combinations will be selected
#' instead of 30.
#'
#' This is repeated for both conditions and another level of combination
#' is performed to combine samples from the two conditions. Again, only
#' x number of unique combinations selected. When total unique combination
#' is smaller than x, then all unique combinations are selected.
#'
#' Selected combinations of samples at each replicate number are then
#' returned.
#'
#' @param condition_table A condition table with two columns and each sample
#' as a row. Column 1 contains sample names and Column 2 contains sample
#' condition (e.g. Control, Treatment).
#' @param n_repetition The number of maximum unique combinations to generate
#' at each replicate level. More tests will be performed with a bigger value,
#' but run time also increases linearly. Default set to 30 unique combinations.
#'
#' @return A list of character vectors containing sample combinations. Each
#' element in the list corresponds to a replicate level. Each combination
#' within the character vector is a single string with sample names separated
#' by semicolon.
#'
#' @author Zixuan Shao, \email{Zixuanshao.zach@@gmail.com}
#'
#' @examples
#' # Use example condition_table
#' # example dataset containing 1000 genes, 4 replicates and 5 comb. per rep.
#' # level
#' data(condition_table.partial, package = "ERSSA")
#'
#' combinations.partial = comb_gen(condition_table.partial, n_repetition=5)
#'
#' @export
#'
#' @importFrom utils write.csv
#' @importFrom plyr ldply


comb_gen = function(condition_table=NULL, n_repetition=30){

    # check all required arguments supplied
    if (is.null(condition_table)){
        stop('Missing required condition_table argument in comb_gen function')
    } else if (!(is.data.frame(condition_table))){
        stop('condition_table is not an expected data.frame object')
    }

    # rename input condition table column name
    colnames(condition_table) = c('sample_name','condition')

    # confirm only two conditions for comparison
    unique_conditions = unique(condition_table$condition)
    if (length(unique_conditions) != 2){
        stop('Only two conditions supported, e.g. Ctrl and Treatment.')
    }

    # confirm sample name does not contain semicolon
    sample_names = condition_table$sample_name
    contain_semic = sapply(sample_names, function(x) grepl(';', x))
    if (sum(contain_semic)>0){
        stop('Sample name cannot contain semicolon.')
    }

    # samples names associated with each condition
    cond1_name = as.character(condition_table$sample_name[
        which(condition_table$condition == unique_conditions[1])])
    cond2_name = as.character(condition_table$sample_name[
        which(condition_table$condition == unique_conditions[2])])
    min_sample_size = min(length(cond1_name),length(cond2_name))

    # master list with replicate as names with each element containing vector
    # of combinations.
    replicate_combs = lapply(seq(2, min_sample_size-1), function(rep) {

        # generate unique combination of condition 1 samples at sepcified
        # repetition set repetition to smaller of two: n_repetition,
        # n_combination
        comb_rep = n_repetition
        n_combination_cond1 = choose(length(cond1_name),rep)
        if (n_combination_cond1<n_repetition){
            comb_rep = n_combination_cond1
        }

        # generate comb_rep number of combinations for condition 1
        comb_cond1_list = vector(mode="character", length=comb_rep)
        count = 0

        while (count != comb_rep){
            # random samping without replacement
            comb_cond1 = sort(sample(cond1_name, rep))
            # collapse into one string
            comb_cond1_string = paste(as.character(comb_cond1), collapse=';')

            if (!(comb_cond1_string %in% comb_cond1_list)) {
                # add to combination list if string is unique
                comb_cond1_list[count+1] = comb_cond1_string
                count = count + 1
            }
        }

        # repeat for condition 2
        # set repetition to smaller of two: n_repetition, n_combination
        comb_rep = n_repetition
        n_combination_cond2 = choose(length(cond2_name),rep)
        if (n_combination_cond2<n_repetition){
            comb_rep = n_combination_cond2
        }

        # generate comb_rep number of combinations for condition 2
        comb_cond2_list = vector(mode="character", length=comb_rep)
        count = 0

        while (count != comb_rep){
            # random samping without replacement
            comb_cond2 = sort(sample(cond2_name, rep))
            # collapse into one string
            comb_cond2_string = paste(as.character(comb_cond2), collapse=';')

            if (!(comb_cond2_string %in% comb_cond2_list)) {
                # add to combination list if unique
                comb_cond2_list[count+1] = comb_cond2_string
                count = count + 1
            }
        }

        # generate combinations of condition 1 and 2
        comb_rep = n_repetition
        n_combination_merged = length(comb_cond1_list)*length(comb_cond2_list)
        if (n_combination_merged<n_repetition){
            comb_rep = n_combination_merged
        }

        # generate comb_rep number of combinations of condition 1 and 2
        comb_merged_list = vector(mode="character", length=comb_rep)
        count = 0

        while (count != comb_rep){
            # random samping without replacement
            comb_merged = as.character(sample(comb_cond1_list, 1))
            comb_merged = c(comb_merged, as.character(sample(comb_cond2_list,1)))
            # collapse into one string
            comb_merged_string = paste(comb_merged, collapse=';')

            if (!(comb_merged_string %in% comb_merged_list)) {
                # add to combination list if unique
                comb_merged_list[count+1] = comb_merged_string
                count = count + 1
            }
        }

        return(comb_merged_list)
    })

    names(replicate_combs) = paste0('rep_', seq(2, min_sample_size-1))

    replicate_combs[['full']] = paste(condition_table$sample_name, collapse=';')

    return(replicate_combs)
}





