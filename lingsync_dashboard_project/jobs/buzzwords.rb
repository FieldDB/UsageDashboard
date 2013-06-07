# :first_in sets how long it takes before the job is first run. In this case, it is run immediately

json = '[{
  "word" : "word1"
}, {
  "word" : "word2"
}, {
  "word" : "word3"
}, {
  "word" : "word4"
}, {
  "word" : "word5"
}, {
  "word" : "word6"
}, {
  "word" : "word7"
}, {
  "word" : "word8"
}, {
  "word" : "word9"
}, {
  "word" : "word10"
}, {
  "word" : "word11"
}, {
  "word" : "word12"
}, {
  "word" : "word13"
}]'

buzzwords = JSON.parse json

SCHEDULER.every '2s', :first_in => 0 do |job|
  send_event('buzzwords', { text: buzzwords[rand(buzzwords.length - 1)]['word'] })
end