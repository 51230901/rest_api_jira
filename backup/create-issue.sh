#!/bin/bash

token=$(cat test-token)
# url='istrd.atlassian.net'
url='zl-chen.atlassian.net'
account='zl_chen@chiconypower.com'

curl --request GET \
  --url "https://${url}/rest/api/3/user/search?query=zl_chen" \
  --user "${account}:${token}" \
  --header 'Accept: application/json' > accountId.json

# curl --request POST \
#   --url "https://${url}/rest/api/3/issue" \
#   --user "${account}:${token}" \
#   --header 'Accept: application/json' \
#   --header 'Content-Type: application/json' \
#   --data '{
#   "fields": {
#     "assignee": {
#       "id": "712020:ee710e6b-7fc4-4ebb-bffb-09aba0eaadee"
#     },
#     "description": {
#       "content": [
#         {
#           "content": [
#             {
#               "text": "Order entry fails when selecting supplier.",
#               "type": "text"
#             }
#           ],
#           "type": "paragraph"
#         }
#       ],
#       "type": "doc",
#       "version": 1
#     },
#     "issuetype": {
#       "name": "Bug"
#     },
#     "priority": {
#       "name": "High"
#     },
#     "project": {
#       "key": "AT"
#     },
#     "reporter": {
#       "accountId": "712020:ee710e6b-7fc4-4ebb-bffb-09aba0eaadee"
#     },
#     "summary": "Main order flow broken"
#   },
#   "update": {}
# }'