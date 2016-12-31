#!/bin/bash

currentdir=$(cd `dirname $0`; pwd)

method=POST
host=mosapi.meituan.com
api=/mcs/v1

#美团共有云API地址
mosURL="https://$host$api"

getsignature() {
  secret=$1
  params=$2
  text=`echo "$method\n$host\n$api\n$params"`
  signature=`$currentdir/hmacsha256.py $secret "$text"`
  echo $signature
}

doPost() {
  action=$1
  accesskey=$2
  secret=$3
  params=$4
  timestamp=`date '+%Y-%m-%dT%H:%M:%SZ'`
  action="Action=$1"
  accesskey="AWSAccessKeyId=$2"
  tsparam="Timestamp=$timestamp"
  version="SignatureVersion=2"
  signature_method="SignatureMethod=HmacSHA256"
  format="Format=json"
  ts_encoded=`echo $tsparam | sed 's/:/%3A/g'`
  auth_params="$accesskey&$action&$format&$signature_method&$version&$ts_encoded"
  signature=`getsignature $secret $auth_params`
  if [ -z "$params" ]; then 
    echo `curl -d "$action" -d "$accesskey" -d "$tsparam" -d "$version" -d "$signature_method" -d "$format" -d "Signature=$signature" https://mosapi.meituan.com/mcs/v1`
  else
    echo `curl -d "$action" -d "$accesskey" -d "$tsparam" -d "$version" -d "$signature_method" -d "$format" -d "Signature=$signature" -d "$params" https://mosapi.meituan.com/mcs/v1`
  fi  
}
