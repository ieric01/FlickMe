FactoryGirl.define do 
	sequence :email do |i|
		"email#{i}@factory-mail.com"	
	end

	factory  :user do
		email 
		password "abcd1234"
	end
end