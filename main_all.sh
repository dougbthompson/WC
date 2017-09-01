#!/bin/bash

source /home/dougt/.bashrc
export DATA_DIR=/home/dougt/wc/wc/data/
export OTHER="other"

cd /home/dougt/wc/wc

R --silent --vanilla < main_all.R

