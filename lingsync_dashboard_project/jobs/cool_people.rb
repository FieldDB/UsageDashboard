json = '[{
  "name" : "M.E. Cathcart",
  "affiliation" : "U Delaware"
}, {
  "name" : "Tobin Skinner",
  "affiliation" : "iLanguage Lab Ltd, UQAM"
}, {
  "name" : "Josh Horner",
  "affiliation" : "iLanguage Lab Ltd"
}, {
  "name" : "Gina Cook",
  "affiliation" : "iLanguage Lab Ltd"
}, {
  "name" : "Mathieu Legault",
  "affiliation" : "iLanguage Lab Ltd"
}, {
  "name" : "Theresa Deering",
  "affiliation" : "iLanguage Lab Ltd"
}, {
  "name" : "Yuliya Manyakina",
  "affiliation" : "Stony Brook University"
}, {
  "name" : "Elise McClay",
  "affiliation" : "McGill University"
}, {
  "name" : "Hisako Noguchi",
  "affiliation" : "Concordia University"
}, {
  "name" : "Jesse Pollak",
  "affiliation" : "Pomona College"
}, {
  "name" : "Xianli Sun",
  "affiliation" : "Miami University"
}]'
  
  people = JSON.parse json

# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '3s', :first_in => 0 do |job|
	current_cool_person = people[rand(people.length)]  
	send_event('people_that_rock', { text: current_cool_person["name"], moreinfo: current_cool_person["affiliation"] })
end
