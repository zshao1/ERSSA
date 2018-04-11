# ERSSA
Empirical RNA-seq Sample Size Analysis

Date: 2018-04-11<br>
Version: 0.99.0<br>
Author: Zixuan Shao<br>
Maintainer: Zixuan Shao (zixuanshao.zach@gmail.com)

### Description
ERSSA is a package designed to test whether an currently available RNA-seq dataset has sufficient biological replicates to detect a majority of differentially expressed (DE) genes between two conditions. Base on the number of biological replicates available, the algorithm subsamples at step-wise replicate levels and uses existing differentially expression analysis softwares (e.g. edgeR and DESeq2) to identify the number of DE genes. This process is repeated for a given number of times with unique combinations of samples to generate a distribution of DE genes at each replicate level. Compare to existing RNA-seq sample size analysis algorithms, ERSSA does not rely on any a priori assumptions about the dataset, but rather uses an user-supplied pilot RNA-seq dataset to determine whether the current replicate level is sufficient to detect a majority of DE genes.

### Usage
See [ERSSA vignette](./vignettes/ERSSA.html) for detailed usage information.
