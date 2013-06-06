#!/usr/bin/env ruby
require 'net/http'
require 'json'

json = '[{
"number": 967,
"title": "Configure Dashing dashboard with github commit statistics.",
"state": "open"
},{
"number": 965,
"title": "Configure Dashing to use server information",
"state": "open"
},{
"number": 964,
"title": "Install and configure Splunk",
"state": "open"
},{
"number": 959,
"title": "does \"edit tags\" actually edit tags?",
"state": "open"
},{
"number": 958,
"title": "does \"edit session info\" actually edit your session info?",
"state": "open"
},{
"number": 957,
"title": "if a search returns a field that\'s not displayed, indicate which field it is",
"state": "open"
},{
"number": 956,
"title": "\'enter\' should do the same thing as clicking \'done\' for both templates",
"state": "open"
},{
"number": 954,
"title": "Make datum bubles clickable to search for data with that string in morpheme vis",
"state": "open"
},{
"number": 951,
"title": "Turn d3 data into linguistics data ",
"state": "open"
},{
"number": 949,
"title": "Automatically generate textgrid when the user drags and drops an audio file",
"state": "open"
},{
"number": 946,
"title": "Write end-to-end tests for audio server API",
"state": "open"
},{
"number": 945,
"title": "Implement streaming audio for ranges of time",
"state": "open"
},{
"number": 944,
"title": "Implement half-cached test cases",
"state": "open"
},{
"number": 943,
"title": "Implement API to upload and run aligner",
"state": "open"
},{
"number": 942,
"title": "Implement test case for cached textgrid",
"state": "open"
},{
"number": 941,
"title": "Implement textgrid \"state\" check function",
"state": "open"
},{
"number": 940,
"title": "Design audio server API",
"state": "open"
},{
"number": 930,
"title": "Recursive functions tutorial in JavaScript",
"state": "open"
},{
"number": 929,
"title": "Automatic creation of bare phrase structure trees",
"state": "open"
},{
"number": 928,
"title": "d3 tree visualization of sentences/morphemes",
"state": "open"
},{
"number": 924,
"title": "Deploy the spreadsheet app",
"state": "open"
},{
"number": 920,
"title": "add function to save an image into a datum",
"state": "open"
},{
"number": 909,
"title": "Use the new datum model instead of the old one",
"state": "open"
},{
"number": 899,
"title": "Make visualization with Morphemes in Utterances",
"state": "open"
},{
"number": 879,
"title": "Write up an article about lingsync for CAML",
"state": "open"
},{
"number": 876,
"title": "Replication might fail for a corpus with 5000+ items",
"state": "open"
},{
"number": 862,
"title": "Make it possible for users to change their passwords",
"state": "open"
},{
"number": 818,
"title": "BugI don\'t see shared data in shared researchpartnership corpus",
"state": "open"
},{
"number": 806,
"title": "Add a dropdown for corpus templates, and add a few into the new corpus method",
"state": "open"
},{
"number": 486,
"title": "See about supporting sound cloud for audio",
"state": "open"
}]'


issuenumber = ''
issuetitle = ''
issuestatus = ''
currentindex = 0
maxindex = 0
totalnumberofrecords = 0
numberofrecordstodisplay = 7 #plus 1 = 10
repos_issues = Array.new

#Fetch data every 60 minutes; github appears to cache this info (daily?); NB: github API limits to 60 hits per hour
SCHEDULER.every '60m', :first_in => 0 do |job|
  http = Net::HTTP.new("api.github.com", Net::HTTP.https_default_port())
  http.use_ssl = true
  responseopen = http.request(Net::HTTP::Get.new("/repos/OpenSourceFieldlinguistics/FieldDB/issues?state=open"))
  responseclosed = http.request(Net::HTTP::Get.new("/repos/OpenSourceFieldlinguistics/FieldDB/issues?state=closed"))
  
  if responseopen.code != "200"
    puts "github api error (status-code: #{responseopen.code})\n#{responseopen.body}"
    data = JSON.parse(json)
  else
    data = JSON.parse(responseopen.body) + JSON.parse(responseclosed.body)
  end
  
  repos_issues = Array.new
     data.each do |repo|
      repos_issues.push({
      number: repo['number'],
      titleofissue: repo['title'],
      status: repo['state']
     })
     end
  
  repos_issues = repos_issues.sort { |a,b| a[:number] <=> b[:number] }

  totalnumberofrecords = repos_issues.length
  maxindex = totalnumberofrecords - numberofrecordstodisplay
     
  
end # SCHEDULER

#Cycle through data in DOM every 5s
SCHEDULER.every '1s', :first_in => 0 do |job|
  if repos_issues[0]
    send_event('fielddb_issues', { items: repos_issues[currentindex..currentindex+numberofrecordstodisplay] })
  else
    send_event('fielddb_issues', { items: [{ number: 'Loading', titleofissue: 'Loading', status: 'Loading' }] })
  end #if
  
  if currentindex < maxindex
    currentindex += 1
  else
    currentindex = 0
  end #if
  
end # SCHEDULER