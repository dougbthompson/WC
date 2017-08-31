#!/usr/bin/R

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

app_locations_csv = function(locations) {

  data_dir = '/home/dougt/wc/wc/data/'
  eventid <- '2000000163'

  if (nrow(locations)) {
    julian_unix_day_0 = 2440587.500000
    seconds_per_day = 24 * 60 * 60

    locations %>%
      transmute(
        lat1=latitude
       ,lat2=latitude
       ,long1=longitude
       ,long2=longitude
       ,lc = location_class
       ,decimal_day = (date/seconds_per_day) + julian_unix_day_0) -> filtered_output

    csv = paste0(data_dir, eventid, '.csv')
    write.table(file=csv, filtered_output, row.names=F, quote=F,sep='\t')

    return(filtered_output)
  }
}

app_locations_ssm_csv = function(locations) {

      data_dir = '/home/dougt/wc/wc/data/'
      eventid <- '2000000163'
      csv = paste0(data_dir, eventid, '.csv')

      filtered_output <- locations
      location_filename = paste0(data_dir, eventid, 'SSM.txt')

      fread(paste('ssh argos@mola "nosql repair | bin/tab2tabFilter filterLand" <',csv)) %>% filter(passed==1) -> filtered_output

      if (nrow(filtered_output)) {
        filtered_output %>%
        transmute(
           date           = (decimal_day - julian_unix_day_0) * seconds_per_day
          ,latitude       = lat
          ,longitude      = long
          ,location_class = lc
        ) -> filtered_argos

        transmute(
           filtered_argos
          ,datesec = format(anytime(as.numeric(as.character(date))+0), '%m/%d/%Y %H:%M')
          ,lon     = ((as.numeric(as.character(longitude))+180) %% 360) - 180
          ,lat     = as.numeric(as.character(latitude))
          ,lon025=-999 ,lat025=-999 ,lon5=-999 ,lat5=-999
          ,lon975=-999 ,lat975=-999 ,mplon=-999 ,mplat=-999
          ,id=eventid
        ) ->.;

        write.csv(., file = location_filename, quote=F, row.names=F)
        ### system(paste('chmod ugo+rwx', location_filename))
        ### system(paste('scp', location_filename, 'vmuser@mola:/var/www/html/atnupload/embargos/'))
      }
}

