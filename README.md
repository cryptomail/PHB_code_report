# PHB_code_report
I often get asked "What did your team do last week?  What are they doing this week?"
It's not that I don't know, trust me I'm very plugged in.  it's just that I want to be specific, and give supporting data.

Gets a report of a list of users activity for the last week, and what they're likely working on this week.

Not included: users.txt and batteries.

## Directions
1. Construct users.txt with your team's github handles
2. Make sure you have a GH API Token in your environment called `GHA_TOKEN` and that token has to have all the right perms.  (Search / read meta data, access to the repos) etc.
3. run report `sh execute_report.sh $your_repo_name`
4. feed instructions into ChatGPT
5. feed output into https://app.slack.com/block-kit-builder
