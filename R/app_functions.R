
###
### Copyright 2017 (c) Stanford University, Hopkins Marine Station
### Licensed under the Apache License, Version 2.0
###

as.data.frame.list=function(x, row.names=NULL, optional=FALSE, ...) {
  if(!all(unlist(lapply(x, class)) %in% 
    c('raw','character','complex','numeric','integer','logical'))) {
    warning('All elements of the list must be a vector.')
    NextMethod(x, row.names=row.names, optional=optional, ...)
  }

  allequal <- all(unlist(lapply(x, length)) == length(x[[1]]))
  havenames <- all(unlist(lapply(x, FUN=function(x) !is.null(names(x)))))

  if(havenames) { #All the vectors in the list have names we can use
    colnames <- unique(unlist(lapply(x, names)))
    df <- data.frame(matrix(
      unlist(lapply(x, FUN=function(x) { x[colnames] })),
      nrow=length(x), byrow=TRUE))

    names(df) <- colnames
  } else if(allequal) { #No names, but are of the same length
    df <- data.frame(matrix(unlist(x), nrow=length(x), byrow=TRUE), ...)
    hasnames <- which(unlist(lapply(x, FUN=function(x) !is.null(names(x)))))
    if(length(hasnames) > 0) { #We'll use the first element that has names
      names(df) <- names(x[[ hasnames[1] ]])
    }
  } else { #No names and different lengths, we'll make our best guess here!
    warning(paste("The length of vectors are not the same and do not ",
                  "are not named, the results may not be correct.", sep=''))
    # find the largest
    lsizes <- unlist(lapply(x, length))
    start <- which(lsizes == max(lsizes))[1]
    df <- x[[start]]

    for(i in (1:length(x))[-start]) {
      y <- x[[i]]
      if(length(y) < length(x[[start]])) {
        y <- c(y, rep(NA, length(x[[start]]) - length(y)))
      }
      if(i < start) {
        df <- rbind(y, df)
      } else {
        df <- rbind(df, y)
      }
    }
    df <- as.data.frame(df, row.names=1:length(x))
    names(df) <- paste('Col', 1:ncol(df), sep='')
  }

  if(missing(row.names)) {
    row.names(df) <- names(x)
  } else {
    row.names(df) <- row.names
  }
  return(df)
}

