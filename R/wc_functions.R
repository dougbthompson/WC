
###
### Copyright 2017 (c) Stanford University, Hopkins Marine Station
### Licensed under the Apache License, Version 2.0
###

### 
### the key_file is called wc_keys.R, it is being loaded from this
### user account root, looks like:
###
### access_key='5BU3+GDg5= ...'
### secret_key='+Hbl8FjYE= ...'
### 

fetch_wc = function(request) {
  key_file='~/wc_keys.R'
  url='http://my.wildlifecomputers.com/services/'

  if (!file.exists(key_file)) {
    stop(paste('key_file=',key_file,'does not exist.'))
  }

  source(key_file, local=T)
  ### source('check_keys.R',local=T)
  hash = digest::hmac(key=secret_key, object=request, algo="sha256")

  x = POST(
      url=url
     ,config=add_headers('X-Access'=access_key, 'X-Hash'=hash)
     ,encode='form'
     ,body=request)

  if (http_error(x)) {
    warning(paste(
           'request =', request, "\n"
          ,' key_file =', key_file, "\n"
          ,' url =', url, "\n"
          ,' message =', http_status(x)$message, "\n"))
    return(NULL)
  }

  xmlToList(content(type='text', x=x, encoding='UTF-8'))
}

# -----
# functions to flatten lists
# -----

flatten_nested_sublists = function(l) {
  # flatten each sub-list to a list with dotted names
  lapply (X=l, FUN = function(x) { list(unlist(x))[[1]] })
}

flatten_nested_sublists_array = function(l) {
  # flatten each sub-list to a list with dotted names
  # mapply (X=l, FUN = function(x) { list(unlist(x)) })

  ldply (l, data.frame)
}

nested_list2df = function(n) {
  if (is.null(n)) { 
    return(NULL)
  }

  df = as.data.frame.list(flatten_nested_sublists(n), row.names=NULL)

  # convert each column to an appropriate type
  # this is the same thing read.table() does

  colwise(function(f){type.convert(levels(f)[f],as.is=T)})(df)
}

nested_list_array2df = function(n) {
  if (is.null(n)) {
    return(NULL)
  }

  df = as.data.frame.list(flatten_nested_sublists_array(n), row.names=NULL)

  # convert each column to an appropriate type
  # this is the same thing read.table() does

  colwise(function(f){type.convert(levels(f)[f],as.is=T)})(df)
}


# -----
# functions calling fetch_wc.R
# -----

fetch_deployments_atn_dac=function() {
    fetch_wc(request='action=get_deployments_atn_dac')
}
fetch_deployment_profiles_atn_dac=function() {
    fetch_wc(request='action=get_deployment_profiles_atn_dac')
}
fetch_locations=function(id) {
    request = paste("action=get_locations&id=",id,sep="")
    fetch_wc(request=request)
}
fetch_profiles_atn_dac=function(id) {
    request <- paste0('action=get_profiles_atn_dac&id=', id)
    fetch_wc(request=request)
}

# -----
# morph functions, to suit atndac purposes
# -----

extract_argos=function(wc_nested_list) {
        nested_list2df(wc_nested_list$argos)
}
extract_deployments=function(deployment_nested_list){
    nested_list2df(deployment_nested_list)
}
extract_fastloc=function(wc_nested_list) {
        nested_list2df(wc_nested_list$fastloc)
}
extract_profiles = function(profile_nested_list) {
    nested_list_array2df(profile_nested_list)
}

# -----
# our mainline calls these finctions
# ----

fetch_all_deployments = function() {
  fetch_deployments_atn_dac() %>%
  head(-1) %>% 
  extract_deployments %>%
  plyr::rename(c("id" = "wc_id")) %>%
  mutate(
    last_update_date=as.integer(last_update_date),
    two_digit_year=year(anydate(last_update_date+0)) %% 100  #
  ) -> all_deployments

  return (all_deployments)
}
fetch_all_deployment_profiles = function() {
  fetch_deployment_profiles_atn_dac() %>%
  head(-1) %>% 
  extract_deployments %>%
  plyr::rename(c("id" = "wc_id")) %>%
  mutate(
    last_update_date=as.integer(last_update_date),
    two_digit_year=year(anydate(last_update_date+0)) %% 100  #
  ) -> all_deployment_profiles

  return (all_deployment_profiles)
}
fetch_all_locations = function(id) {
  fetch_locations(id=id) %>%
  head(-1) %>%
  extract_argos -> all_locations

  return (all_locations)
}
fetch_all_profiles = function(id) {
  fetch_profiles_atn_dac(id=id) %>%
  head(-1) %>%
  flatten_nested_sublists_array -> all_profiles

  return (all_profiles)
}

# -----

