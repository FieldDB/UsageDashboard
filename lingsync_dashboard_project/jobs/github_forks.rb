#!/usr/bin/env ruby
require 'net/http'
require 'json'

# This job can track metrics of a public visible user or organisation’s repos
# by using the public api of github.
# 
# Note that this API only allows 60 requests per hour.
# 
# This Job should use the `List` widget

# Config
# ------
# example for tracking single user repositories
# github_username = 'users/ephigenia'
# example for tracking an organisations repositories
github_username = 'orgs/OpenSourceFieldlinguistics'
# number of repositories to display in the list
max_length = 5
# order the list by the numbers
ordered = true

SCHEDULER.every '60m', :first_in => 0 do |job|
  http = Net::HTTP.new("api.github.com", Net::HTTP.https_default_port())
  http.use_ssl = true
  response = http.request(Net::HTTP::Get.new("/#{github_username}/repos"))

  data = JSON.parse(response.body)

  if response.code != "200"
    puts "github api error (status-code: #{response.code})\n#{response.body}"
  else
    repos_forks = Array.new
    data.each do |repo|
      repos_forks.push({
        label: repo['name'],
        value: repo['forks']
      })
    end

    if ordered
      repos_forks = repos_forks.sort_by { |obj| -obj[:value] }
    end

    send_event('github_user_repos_forks', { items: repos_forks.slice(0, max_length) })

  end # if

end # SCHEDULER