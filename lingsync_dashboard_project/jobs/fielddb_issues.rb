#!/usr/bin/env ruby
require 'net/http'
require 'json'

issuenumber = ''
issuetitle = ''
issuestatus = ''
currentindex = 0
maxindex = 0
totalnumberofrecords = 0
repos_issues = Array.new
numberofrecordstodisplay = 7 #plus 1 = 10

#Fetch data every 5 minutes
SCHEDULER.every '5m', :first_in => 0 do |job|
  http = Net::HTTP.new("api.github.com", Net::HTTP.https_default_port())
  http.use_ssl = true
  responseopen = http.request(Net::HTTP::Get.new("/repos/OpenSourceFieldlinguistics/FieldDB/issues?state=open"))
  responseclosed = http.request(Net::HTTP::Get.new("/repos/OpenSourceFieldlinguistics/FieldDB/issues?state=closed"))
  
  repos_issues = Array.new
  
  if responseopen.code != "200"
    puts "github api error (status-code: #{responseopen.code})\n#{responseopen.body}"
  else
    data = JSON.parse(responseopen.body) + JSON.parse(responseclosed.body)
    repos_issues = Array.new
         data.each do |repo|
          repos_issues.push({
          number: repo['number'],
          titleofissue: repo['title'],
          status: repo['state']
         })
        end
    repos_issues = repos_issues.sort { |a,b| a[:number] <=> b[:number] }
  end
  
  totalnumberofrecords = repos_issues.length
  maxindex = totalnumberofrecords - numberofrecordstodisplay
     
  
end # SCHEDULER

#Cycle through data in DOM every 3s
SCHEDULER.every '3s', :first_in => 0 do |job|
  if repos_issues[0]
    send_event('fielddb_issues', { items: repos_issues[currentindex..currentindex+numberofrecordstodisplay] })
  else
    send_event('fielddb_issues', { items: [{ number: 'N/A', titleofissue: 'N/A', status: 'N/A' }] })
  end #if
  
  if currentindex < maxindex
    currentindex += 1
  else
    currentindex = 0
  end #if
  
end # SCHEDULER