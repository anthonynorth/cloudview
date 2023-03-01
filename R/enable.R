#' @describeIn cloudview Enable
#' @export
enable_cloudview <- function() {
  register_s3_method("print", "htmlwidget", cloudview, "htmlwidgets")
}

#' @describeIn cloudview Disable
#' @export
disable_cloudview <- function() {
  unregister_s3_method("print", "htmlwidget", "htmlwidgets")
}

register_s3_method <- function(generic, class, fn, pkg) {
  register <- function(...) registerS3method(generic, class, fn, asNamespace(pkg))
  setHook(packageEvent(pkg, "onLoad"), register)
  if (isNamespaceLoaded(pkg)) register()
}

unregister_s3_method <- function(generic, class, pkg) {
  setHook(packageEvent(pkg, "onLoad"), NULL, "replace")
  if (isNamespaceLoaded(pkg)) {
    ns <- asNamespace(pkg)
    registerS3method(generic, class, utils::getS3method(generic, class, FALSE, ns), ns)
  }
}
