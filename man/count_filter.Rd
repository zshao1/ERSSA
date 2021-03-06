% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/count_filter.R
\name{count_filter}
\alias{count_filter}
\title{Filter RNA-seq expression table}
\usage{
count_filter(count_table = NULL, cutoff = 1)
}
\arguments{
\item{count_table}{A RNA-seq count matrix with genes on each row and samples
on each column.}

\item{cutoff}{Any gene with average CPM below this cutoff value will be
filtered out.}
}
\value{
The filtered count table.
}
\description{
\code{count_filter} function filters the RNA-seq count table to remove
non- and low-expression genes at an defined average CPM cutoff (Default=1).
}
\examples{
# load simple GTeX example count table
# example dataset containing 1000 genes, 4 replicates
data(count_table.partial, package = "ERSSA")

#filter the counts
count_table.filtered.partial = count_filter(count_table.partial)

}
\author{
Zixuan Shao, \email{Zixuanshao.zach@gmail.com}
}
