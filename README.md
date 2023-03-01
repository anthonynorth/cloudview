
# cloudview

<!-- badges: start -->
[![lifecycle](https://img.shields.io/badge/lifecycle-experimental-orange.svg)](https://lifecycle.r-lib.org/articles/stages.html#experimental)
[![release](https://img.shields.io/github/v/release/anthonynorth/cloudview?include_prereleases&logo=github&sort=semver)](https://github.com/anthonynorth/cloudview/releases/latest)
[![latest](https://img.shields.io/github/r-package/v/anthonynorth/cloudview?label=latest&logo=r)](https://github.com/anthonynorth/cloudview/latest)
[![R-CMD-check](https://github.com/anthonynorth/cloudview/actions/workflows/R-CMD-check.yaml/badge.svg)](https://github.com/anthonynorth/cloudview/actions/workflows/R-CMD-check.yaml)
<!-- badges: end -->

View `htmlwidget` objects over ssh connections with vscode-remote.

## Installation

You can install the development version of cloudview from [GitHub](https://github.com/) with:

```r
# install.packages("devtools")
devtools::install_github("anthonynorth/cloudview")
```

## Usage

Cloudview can be used to explicitly serve a `htmlwidget` with `cloudview(object)`, or you can setup `cloudview` to implicitly serve widgets on `print(view = TRUE)`.

Serving htmlwidgets on `print(view = TRUE)` is achieved with `enable_cloudview()`. This function masks `print.htmlwidget` with a wrapper function that replaces the `viewer()` which is called when running R interactively (by default). Undo this operation with `disable_cloudview()`.

Add `enable_cloudview()` to `.Rprofile` to always serve widgets on `print(view = TRUE)`. Example from my dot-files:

```r
# serve htmlwidgets with servr
local({
  has_cloudview <- "cloudview" %in% .packages(all.available = TRUE)
  is_ssh <- Sys.getenv("SSH_CONNECTION") != ""
  if (interactive() && is_ssh && has_cloudview) cloudview::enable_cloudview()
})
```
