#!/usr/bin/python

import subprocess
import sys

host = raw_input("Enter the hostname you want to connect \n ")
COMMAND="uname -a"

ssh = subprocess.Popen(["ssh", "%s" % host , COMMAND],
                       shell=False,
                       stdout=subprocess.PIPE,
                       stderr=subprocess.PIPE)
result = ssh.stdout.readlines()
if result == []:
    error = ssh.stderr.readlines()
    print >>sys.std
else:
    print result
