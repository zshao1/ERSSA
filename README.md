# ERSSA: Empirical RNA-seq Sample Size Analysis

Date: 2018-06-01<br>
Version: 0.99.0<br>
Author: Zixuan Shao and Julie Kornfield<br>
Maintainer: Zixuan Shao (zixuanshao.zach@gmail.com)

### Description
Sample size calculation is an important optimization step in any comparative RNA sequencing (RNA-seq) analysis. Empirical RNA-seq Sample Size Analysis (ERSSA) is a R software package designed to test whether an existing RNA-seq dataset has sufficient biological replicates to detect a majority of the differentially expressed genes (DEGs) between two conditions. Compare to existing RNA-seq sample size analysis algorithms, ERSSA does not rely on any a priori assumptions about the dataset. Rather, ERSSA uses an user-supplied pilot RNA-seq dataset to test whether the current replicate level is sufficient to detect a majority of DEGs. 

Base on the number of replicates available, the algorithm subsamples at step-wise replicate levels and uses existing differentially expression (DE) analysis softwares (e.g. edgeR and DESeq2) to identify the number of DEGs at each level. This process is repeated for a sufficient number of times with unique combinations of samples to generate a distribution of the number of DEGs at each replicate level. Once all of the DE comparisons are done, the DEG numbers are then plotted and base on the trend in the plot, the user can assess whether sufficient biological replicates have been employed.

When applied to RNA-seq data from studies including GTEx, ERSSA demonstrated proficiency in determining whether sufficient biological replicates have been included in the differential expression comparison. Overall, ERSSA can be used as a flexible and easy-to-use tool that offers an alternative approach to identify the appropriate sample size in comparative RNA-seq studies.

### Usage
See [ERSSA vignette](./vignettes/ERSSA.html) for detailed usage information.
