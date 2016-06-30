#!/bin/bash
COUNTER=$1
for (( c=1; c<=COUNTER; c++))
do
 cp /etc/asterisk/test/number.bak /etc/asterisk/test/number.call
 chmod 777 /etc/asterisk/test/number.call
 chown asterisk:asterisk /etc/asterisk/test/number.call
 mv /etc/asterisk/test/number.call /var/spool/asterisk/outgoing/
 sleep 3
done
