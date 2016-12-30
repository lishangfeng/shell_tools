#!/usr/bin/env python
# -*- coding: utf-8 -*-

import base64
import hashlib
import hmac
import sys

args = sys.argv
secret = args[1]
data = args[2].replace("\\n","\n")

data_encoded = bytes(data).encode('utf-8')
secret_encoded = bytes(secret).encode('utf-8')

signature = base64.b64encode(hmac.new(secret_encoded, data_encoded, digestmod=hashlib.sha256).digest())
print(signature)
