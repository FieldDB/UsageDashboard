# :first_in sets how long it takes before the job is first run. In this case, it is run immediately
SCHEDULER.every '3s', :first_in => 0 do |job|
	people = ["Tobin", "Josh", "Gina", "Mathieu"]
	current_cool_person = people[rand(people.length)]  
	send_event('people_that_rock', { current: current_cool_person })
end
