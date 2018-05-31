# ERSSA
Empirical RNA-seq Sample Size Analysis

Date: 2018-04-11<br>
Version: 0.99.0<br>
Author: Zixuan Shao<br>
Maintainer: Zixuan Shao (zixuanshao.zach@gmail.com)

### Description
Sample size calculation is an important optimization step in any comparative RNA sequencing (RNA-seq) analysis. Empirical RNA-seq Sample Size Analysis (ERSSA) is a R software package designed to test whether an existing RNA-seq dataset has sufficient biological replicates to detect a majority of differentially expressed genes (DEGs) between two conditions. Compare to existing RNA-seq sample size analysis algorithms, ERSSA does not rely on any a priori assumptions about the dataset. Rather ERSSA uses the supplied pilot RNA-seq dataset to test whether the current replicate level is sufficient to detect a majority of DEGs. 

Base on the number of replicates available, the algorithm subsamples at step-wise replicate levels and uses existing differentially expression analysis software (e.g. edgeR and DESeq2) to identify the number of DEGs at each level. This process is repeated for a sufficient number of times with unique combinations of samples at each level to generate a distribution of the number of DEGs at each replicate level. 

When applied to RNA-seq data from studies including GTeX, ERSSA efficiently identified whether sufficient biological replicates have been included in the differential expression comparison. Overall, ERSSA is a flexible and easy-to-use tool that offers an alternative approach to identify the appropriate sample size in comparative RNA-seq studies.

### Usage
See [ERSSA vignette](./vignettes/ERSSA.html) for detailed usage information.
