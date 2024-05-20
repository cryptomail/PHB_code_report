#!/bin/zsh
echo > output
cat gpt_instructions >> output
echo "" >> output
ruby phb_code_reporter.rb $1 >> output
echo "go to https://app.slack.com/block-kit-builder and have fun"
