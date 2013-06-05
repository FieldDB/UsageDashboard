json = '[{
  "name" : "M.E."
}, {
  "name" : "Tobin"
}, {
  "name" : "Josh"
}, {
  "name" : "Gina"
}, {
  "name" : "Mathieu"
}, {
  "name" : "Theresa"
}, {
  "name" : "Yuliya"
}, {
  "name" : "Elise"
}, {
  "name" : "Hisako"
}, {
  "name" : "Jesse"
}, {
  "name" : "Xianli"
}]'
  
  people = JSON.parse json

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '3s', :first_in => 0 do |job|
	current_cool_person = people[rand(people.length)]  
	send_event('people_that_rock', { text: current_cool_person["name"] })
end
