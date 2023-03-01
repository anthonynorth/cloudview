#' Cloudview
#'
#' Serves htmlwidgets with [servr::httd()]
#' @name cloudview
#' @inheritParams base::print
#'
#' @author Miles McBain
#' @export
cloudview <- function(x, ...) {
  viewer <- getOption("viewer", utils::browseURL)
  htmlwidgets_print <- utils::getS3method("print", "htmlwidget", envir = asNamespace("htmlwidgets"))

  withr::with_options(
    list(viewer = function(url, ...) {
      get_url_dir <- function(url) gsub("file://|/index.html", "", url)
      server <- servr::httd(
        dir = get_url_dir(url),
        verbose = TRUE,
        browser = FALSE
      )

      viewer(server$url)
    }),
    htmlwidgets_print(x, ...)
  )
}
