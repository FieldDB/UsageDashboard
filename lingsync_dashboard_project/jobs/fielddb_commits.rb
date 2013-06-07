#!/usr/bin/env ruby
require 'net/http'
require 'json'

totalyearcommits = 0
totalmonthcommits = 0
totalweekcommits = 0

currentindex = 0

#Fetch data every 60 minutes; github appears to cache this info (daily?); NB: github API limits to 60 hits per hour
SCHEDULER.every '60m', :first_in => 0 do |job|
  http = Net::HTTP.new("api.github.com", Net::HTTP.https_default_port())
  http.use_ssl = true
  response = http.request(Net::HTTP::Get.new("/repos/OpenSourceFieldlinguistics/FieldDB/stats/participation"))

  data = JSON.parse(response.body)
  
  if response.code != "200"
    puts "github api error (status-code: #{response.code})\n#{response.body}"
  else
    totalyearcommits = 0
    totalmonthcommits = 0
    totalweekcommits = 0
    
    yearcommits = data['all']
    monthcommits = data['all'][-4..-1]
  
    totalweekcommits = data['all'][-1]
    
    yearcommits.each do |repo|
      totalyearcommits = totalyearcommits + repo
    end
    
    monthcommits.each do |repo|
      totalmonthcommits = totalmonthcommits + repo
    end
    
  end
    
end # SCHEDULER

#Cycle through data in DOM every 5s
SCHEDULER.every '5s', :first_in => 0 do |job|
    if currentindex == 0
      timelabelvalue = "This Week"
      commitnumbervalue = totalweekcommits
      lastvalue = totalyearcommits
    elsif currentindex == 1
      timelabelvalue = "This Month"
      commitnumbervalue = totalmonthcommits
      lastvalue = totalweekcommits
    else
      timelabelvalue = "This Year"
      commitnumbervalue = totalyearcommits
      lastvalue = totalmonthcommits
    end #if
    
    if currentindex < 2
      currentindex += 1
    else
      currentindex = 0
    end #if
    
    send_event('fielddb_commits', { timelabel: timelabelvalue, commitnumber: commitnumbervalue, last: lastvalue })

end # SCHEDULER