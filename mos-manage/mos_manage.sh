#!/bin/bash

# 管理美团云主机的脚本


. $(cd `dirname $0`; pwd)/basefunction.sh

#$1 Action
#$2 access key
#$3 access secret
response=`doPost $1 $2 $3`
echo $response