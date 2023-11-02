#! /bin/bash

export

echo "Checking jq"
echo "abc" | jq '.'
echo "Checking gh"
gh

while true ; do
    response=$(curl -L -s \
      -H "Accept: application/vnd.github+json" \
      -H "Authorization: Bearer $(gh auth token)" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
      https://api.github.com/repos/jsimpson-gro/workflows/commits/d4e27d5826d2f66c215a205dcaa40a59d287599e/check-suites)

    suite_status=$(echo "${response}" | jq -r '.check_suites[0].status')

    suite_conclusion=$(echo "${response}" | jq -r '.check_suites[0].conclusion')

    if [[ $suite_status == "complete" ]]; then
        echo "${suite_conclusion}"
        break
    fi
    sleep 1
done
