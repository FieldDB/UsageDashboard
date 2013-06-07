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
max_length = 1

SCHEDULER.every '30m', :first_in => 0 do |job|
  #Get number of forks from GitHub
  http = Net::HTTP.new("api.github.com", Net::HTTP.https_default_port())
  http.use_ssl = true
  responseforks = http.request(Net::HTTP::Get.new("/#{github_username}/repos"))
  data = JSON.parse(responseforks.body)

  #Get number of dbs from CouchDB  
  uri = URI.parse("https://corpusdev.lingsync.org/_all_dbs")
  http = Net::HTTP.new(uri.host, uri.port)
  http.use_ssl = true
  http.verify_mode = OpenSSL::SSL::VERIFY_NONE
  request = Net::HTTP::Get.new(uri.request_uri)
  responsenumberofdbs = http.request(request)
  dbs = responsenumberofdbs.body
  dbs = JSON.parse dbs
  
  repos_forks = Array.new

  if responseforks.code != "200"
    puts "github api error (status-code: #{responseforks.code})\n#{responseforks.body}"

    repos_forks.push({
        label: "N/A",
        value: "N/A"
    })    
  else    
    data.each do |repo|
      repos_forks.push({
        label: repo['name'],
        value: repo['forks']
      })
    end

    repos_forks = repos_forks.sort_by { |obj| -obj[:value] }

  end # if
  
  if responsenumberofdbs.code != "200"
      puts "couchdb error (status-code: #{responsenumberofdbs.code})\n#{responsenumberofdbs.body}"
      dbquantity = 0
  else
    dbquantity = dbs.length - 2
  end #if
      
  send_event('fielddb_stats', { forks: repos_forks[0][:value], dbcount: dbquantity })

end # SCHEDULER