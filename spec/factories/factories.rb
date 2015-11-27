
FactoryGirl.define do
	factory :course do
		title 		"Ruby Fundamentals"
		description "Learn ruby syntax, control flow, and looping"
		cost 		99
	end
	factory  :user do
		email 	 "test@gmail.com"
		password "abcd1234"
	end
end