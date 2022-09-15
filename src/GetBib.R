#!/usr/bin/env -S Rscript --vanilla
##  Copyright (C) 2022  Nathan Constantine-Cooke
##
##  Released under MIT license

require(httr, quietly = TRUE)
require(docopt, quietly = TRUE)
# Also requires Python

doc <- "Usage: GetBib [options] <DOI>

Options:
 -f file, --file=file  Name of BibTeX file to write to.

Simple tool for generating a BibTeX entry from a DOI"

opt <- docopt(doc, version = "0.1")

headers <- c(Accept = "application/x-bibtex")

res <- GET(
  url = paste0("https://doi.org/", opt$DOI),
  add_headers(.headers = headers)
)

if (res$headers$`content-type` != "application/x-bibtex") {
  stop("DOI not found", call. = FALSE)
}

cat(content(res, "text", encoding = "UTF-8"))

if (length(opt$file) != 0) {
  write(content(res, "text", encoding = "UTF-8"),
    file = opt$file,
    append = TRUE
  )
}
