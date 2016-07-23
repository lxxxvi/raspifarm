#!/bin/bash

#
#  1  MemAvailable=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.2021.4.6.0`
#  2  Memtotal=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.2021.4.5.0`
#  3  MemShared=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.2021.4.13.0`
#  4  MemBuffer=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.2021.4.14.0`
#  5  MemCached=`snmpget -v 2c -c $PASSWORD -O qv $NASIP 1.3.6.1.4.1.2021.4.15.0`

#    MemFREE=$(($MemAvailable + $MemShared + $MemBuffer + $MemCached))
#    MemUsepercent=$(((($Memtotal - $MemFREE) * 100) / $Memtotal)) // For Available use MemUsepercent=$(((($MemFREE) * 100) / $Memtotal))
#    # Send data
#    curl -s -i -H "Accept: application/json" "http://$DOMO_IP:$DOMO_PORT/json.htm?type=command&param=udevice&idx=$NAS_MEM_IDX&nvalue=0&svalue=$MemUsepercent"

# iso.3.6.1.2.1.25.2.3.1.5.1 = INTEGER: 948012      # available
# iso.3.6.1.2.1.25.2.3.1.5.3 = INTEGER: 1050408     # total
# iso.3.6.1.2.1.25.2.3.1.5.6 = INTEGER: 948012
# iso.3.6.1.2.1.25.2.3.1.5.7 = INTEGER: 147716
# iso.3.6.1.2.1.25.2.3.1.5.8 = INTEGER: 12260


# CPU_IDLE=".1.3.6.1.4.1.2021.11.11.0"
CPU_IDLE=".1.3.6.1.4.1.2021.11.11.0"

MEMORY_AVAILABLE=".1.3.6.1.4.1.2021.4.6.0"
MEMORY_TOTAL=".1.3.6.1.4.1.2021.4.5.0"
MEMORY_SHARED=".1.3.6.1.4.1.2021.4.13.0"
MEMORY_BUFFER=".1.3.6.1.4.1.2021.4.14.0"
MEMORY_CACHED=".1.3.6.1.4.1.2021.4.15.0"

#MEM_AVAIL=".1.3.6.1.2.1.25.2.3.1.5.1"       # .1.3.6.1.4.1.2021.4.5.0
#MEM_USED=".1.3.6.1.2.1.25.2.3.1.6.1"

res=$(snmpget -Oqv -t 1 -c public -v 1 $1 $CPU_IDLE $MEMORY_AVAILABLE $MEMORY_TOTAL $MEMORY_SHARED $MEMORY_BUFFER $MEMORY_CACHED)

echo $res | sed 's/ /,/g'
