#!/bin/bash

source /home/dougt/.bashrc
export DATA_DIR=/home/dougt/wc/wc/data/
export OTHER="other"

cd /home/dougt/wc/wc
cp data/* data.old
rm data/5*

psql -p 5433 -U dougt atndb -c "delete from biologging.event; copy biologging.event from '/home/dougt/wc/wc/xls/event.csv' delimiters '|' csv;"
psql -p 5433 -U dougt atndb -c "delete from biologging.atn_track; copy biologging.atn_track from '/home/dougt/wc/wc/xls/atn_track.csv' delimiters '|' csv;"

R --silent --vanilla < main.R

export DT=`date "+%Y-%m-%d"`

cd /home/dougt/wc/wc

echo ""              > /tmp/wc.dat
# ./main2.sh        >> /tmp/wc.dat
./main3.sh          >> /tmp/wc.dat
echo ""             >> /tmp/wc.dat
./main3.sh .csv csv >> /tmp/wc.dat
echo ""             >> /tmp/wc.dat

psql -p 5433 -U dougt atndb -c "select n_live_tup, relname FROM pg_stat_user_tables where schemaname = 'biologging' and relname like 'atn%' ORDER BY 2;" >> /tmp/wc.dat

psql -p 5433 -U dougt atndb -c "select n_live_tup, relname FROM pg_stat_user_tables where schemaname = 'biologging' and relname like 'atn%' ORDER BY 2;" | egrep "\|" | egrep -v "relname" | cut -c1-11 > xls/cnt.${DT}.txt

echo ""    >> /tmp/wc.dat
ls -alR    >> /tmp/wc.dat

# cat /tmp/wc.dat | mailx -s"SYS:SQL ${DT}" dbt@stanford.edu
/usr/bin/nawk -F, '
        BEGIN {
                print "From: ray@stanford.edu"
                print "To: dbt@stanford.edu"
                print "Subject: WC '${DT}'"
                print "MIME-Version: 1.0"
                print "Content-Type: text/html; charset=us-ascii"
                print "Content-Disposition: inline"
                print "<HTML>"
                print "<BODY>"
                print "<PRE>"
        }
        {
        print $1
        }
        END {
                print "</PRE>"
                print "</BODY>"
                print "</HTML>"
        }
' /tmp/wc.dat | /usr/sbin/sendmail -t

# rm /tmp/wc.dat

