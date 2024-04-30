#!/bin/bash

token=$(cat test-token)
# url='istrd.atlassian.net'
url='zl-chen.atlassian.net'
account='zl_chen@chiconypower.com'

curl --request GET \
  --url "https://${url}/rest/api/3/user/search?query=zl_chen" \
  --user "${account}:${token}" \
  --header 'Accept: application/json' > accountId.json

accountId=$(cat accountId.json | grep -o '"accountId": *"[^"]*"' | cut -d'"' -f4)

echo "AccountId: "
echo ${accountId}

curl --request POST \
  --url "https://${url}/rest/api/3/issue" \
  --user "${account}:${token}" \
  --header 'Accept: application/json' \
  --header 'Content-Type: application/json' \
  --data "{
  \"fields\": {
    \"assignee\": {
      \"id\": \"${accountId}\"
    },
    \"description\": {
      \"content\": [
        {
          \"content\": [
            {
              \"text\": \"Order entry fails when selecting supplier.\",
              \"type\": \"text\"
            }
          ],
          \"type\": \"paragraph\"
        }
      ],
      \"type\": \"doc\",
      \"version\": 1
    },
    \"issuetype\": {
      \"name\": \"Bug\"
    },
    \"priority\": {
      \"name\": \"High\"
    },
    \"project\": {
      \"key\": \"AT\"
    },
    \"reporter\": {
      \"accountId\": \"${accountId}\"
    },
    \"summary\": \"Main order flow broken\"
  },
  \"update\": {}
}" > create-issue-ack.json

ack=$(cat create-issue-ack.json | grep -o '"self": *"[^"]*"' | cut -d'"' -f4)
key=$(cat create-issue-ack.json | grep -o '"key": *"[^"]*"' | cut -d'"' -f4)

echo "REST API ACK: ${ack}"
# echo "Issue: ${key}, https://istrd.atlassian.net/jira/software/c/projects/PHIL/issues/${key}"
echo "Issue: ${key}, https://zl-chen.atlassian.net/jira/software/c/projects/AT/issues/${key}"

message_ack="REST API ACK: ${ack}"
message_key="Issue: https://zl-chen.atlassian.net/jira/software/c/projects/AT/issues/${key}"

curl https://notify-api.line.me/api/notify -H 'Authorization: Bearer n3gi7cXRYrdp8wvwH1bhl84xYpjQuwZJPxFdwQeZCo5' -F "message=$(echo -e "${message_ack}\n${message_key}")"