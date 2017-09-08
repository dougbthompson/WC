#!/usr/bin/R

###
### Copyright 2017 (c) Stanford University, Hopkins Marine Station
### Licensed under the Apache License, Version 2.0
###

app_env_params = function() {

  env <- Sys.getenv()

  setClass ("app_env_class", representation(data_dir="character", other="character"))

  app_env <- new("app_env_class",
            data_dir  = env[["DATA_DIR"]],
            other     = env[["OTHER"]])

  return (app_env)
}

