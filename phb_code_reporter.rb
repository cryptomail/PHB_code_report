#!/usr/bin/env ruby
#frozen_string_literal: true

require 'octokit'
require 'date'
require 'byebug'
class PHBCodeReporter
  def initialize
    github_access_token = ENV['GHA_TOKEN']
    @octokit_client = Octokit::Client.new(access_token: github_access_token)
  end

  def client
    return @octokit_client
  end

  def find_recent_prs_by_user(repo, user_handle)
    one_week_ago = (DateTime.now - 7).to_time # One week ago from current time
    results = []

    # Retrieve the PRs created or merged by the specific user within the last week
    prs = client.search_issues("repo:#{repo} author:#{user_handle} type:pr", sort: 'updated', order: 'desc')
    continue unless prs
    prs.items.each do |pr|
      # Skip PRs in draft mode
      next if pr.draft == true

      # Check if the PR creation or merge date was within the last week
      next unless (pr.created_at >= one_week_ago) ||
        (pr.merged_at && pr.merged_at >= one_week_ago)

      pr_status = pr.merged_at ? 'merged' : 'created'
      results << {
        user: pr.user.login,
        status: pr_status,
        url: pr.html_url
      }
    end

    results
  end

end

if __FILE__ == $0
  users = []
  all_prs = {}
  reporter = PHBCodeReporter.new
  repository = ARGV[0]
  # Open the file and read it
  File.open("users.txt", 'r') do |file|
    users = file.readlines.map(&:chomp)
  end

  users.each do |user|
    recent_prs = reporter.find_recent_prs_by_user(repository, user)
    all_prs[user] = recent_prs
  end

end

