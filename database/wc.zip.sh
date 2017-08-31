#!/bin/bash 

cat /dev/null > wc.ziptables.sql
for TAB in `echo "argos behavior corrupt divepdt ddn fastlocgps haulout histos lightloc locations xlocations mixlayer pdt series seriesrange sst status stp summary rtc labels rawargos gpe3 dailydata all"`
do 

    sed -e"s/XX/${TAB}/g" wc.zip.txt >> wc.ziptables.sql

done

