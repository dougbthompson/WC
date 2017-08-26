#!/bin/bash

# curl -o 105789.json -X GET --header 'Accept: application/json' 'http://www.marinespecies.org/rest/AphiaDistributionsByAphiaID/105789'
# curl -o 105789.xml -X GET --header 'Accept: application/xml' 'http://www.marinespecies.org/rest/AphiaDistributionsByAphiaID/105789'

while read LINE
do
    export FILE1=`echo ${LINE} | cut -d'=' -f3`
    export FILE2="${FILE1}.html"

    # wget -O ${FILE2} ${LINE}

    curl -o ${FILE1}.adb.json -X GET --header "Accept: application/json" "http://www.marinespecies.org/rest/AphiaDistributionsByAphiaID/${FILE1}"
    curl -o ${FILE1}.arb.json -X GET --header "Accept: application/json" "http://www.marinespecies.org/rest/AphiaRecordByAphiaID/${FILE1}"
    curl -o ${FILE1}.asb.json -X GET --header "Accept: application/json" "http://www.marinespecies.org/rest/AphiaSynonymsByAphiaI/${FILE1}"
    curl -o ${FILE1}.avb.json -X GET --header "Accept: application/json" "http://www.marinespecies.org/rest/AphiaVernacularsByAphiaID/${FILE1}"

    # curl -o ${FILE1}.xml  -X GET --header "Accept: application/xml"  "http://www.marinespecies.org/rest/AphiaDistributionsByAphiaID/${FILE1}"

done < worms.species.list

