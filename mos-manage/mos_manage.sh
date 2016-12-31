#!/bin/bash -x

# 管理美团云主机的脚本


. $(cd `dirname $0`; pwd)/basefunction.sh

# $1: Action(request type name)
# $2: access key
# $3: access secret
# $4: params, like: "param1=value1&param2=value2"
response=`doPost $1 $2 $3 $4 | jq .`
errorResp=`echo $response | jq .ErrorResponse`
result=`echo $response | jq .${1}Response`
if [ -n "$result" ]; then
  echo $result
else
  echo $errorResp
fi
