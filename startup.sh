#!/bin/bash

SLINGROOT="$(ls -d /root/org.apache.sling.feature.launcher-* | grep -v 'zip$')"
OAKFAR="$(ls /root/*oak*far)"

echo "Host IPs:"
ip addr | awk '/inet[ \t]+[0-9\.]+/ { printf("  - %s\n",gensub(/^.*inet[ \t]+([0-9\.]+)\/[0-9]+.*$/,"\\1","g",$0)); }'

$SLINGROOT/bin/launcher -f $OAKFAR