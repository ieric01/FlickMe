FactoryGirl.define do
	factory :course do
		user #belongs to a user
		title 		"Ruby Fundamentals"
		description "Learn ruby syntax, control flow, and looping"
		cost 		99
	end
end
