#!/bin/bash
killall conky
/usr/bin/conky --pause=5 --daemonize --config=/home/florian/.conky/conky.conf
