#' \code{dopar_progress_bar}
#'
#' Convenient wrapper for generate a progress bar within a parallel loop. Not
#' intended to be called by user. Specifically this is a wrapper function to yield
#' the function for the \code{.combine} operator in \code{foreach}.
#'
#' @param max The number of max iterations to pass to \code{txtProgressBar}
#' @return progress bar function
#'
make_progress_bar <- function(max) {
  dopar_progress_bar <- function(){
    # function to visualize progress bar during dopar process (parallel)
    pb <- txtProgressBar(min=1, max=max-1, style=3)
    count <- 0
    function(...) {
      count <<- count + length(list(...)) - 1
      setTxtProgressBar(pb,count)
      Sys.sleep(0.01)
      flush.console()
      c(...)
    }
  }
  return(dopar_progress_bar)
}

