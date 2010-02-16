#!/bin/bash
# 
# License: This code is licensed as per the LICENSE file
# included.
#
# Script to run a command [stop, start. query, restart]
# against a set of Oracle UCM servers.
# It assumes that you are ussing public/private keys to
# access your servers over SSH.
# Certain environment variables need to be deinfed that set
# the list of servers and the home dir for the the UCM installation.
# An example of how to set these up can be seen in the demo_servers
# file contained within this folder.
#
# Usage:
# idc [start|stop|restart|query]
# e.g.
# idc query
# idc restart
# ...
#
# Todo:
# - Add checking that SERVERS and UCM_HOME has been set
# - Check that the user has passed in the correct command line params
#
# Author: Kris Foster kristian.foster@gmail.com
#

for SERVER in $SERVERS
do
    echo 'Server: '$SERVER
    eval "UCM_HOME=\$$(echo $SERVER'_UCM_HOME')"
    echo 'UCM Home Dir: '$UCM_HOME
    echo '. ~/.profile; /cd '$UCM_HOME'/etc; ./idcserver_'$1';' | ssh $SERVER
done

