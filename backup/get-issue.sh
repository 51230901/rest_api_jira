#!/bin/bash

token=$(cat test-token)
# url='istrd.atlassian.net'
url='zl-chen.atlassian.net'
account='zl_chen@chiconypower.com'

curl --request GET \
  --url "https://${url}/rest/api/3/issue/AT-10" \
  --user "${account}:${token}" \
  --header 'Accept: application/json' > at-10.json