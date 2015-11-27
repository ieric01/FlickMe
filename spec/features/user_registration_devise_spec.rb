require 'spec_helper'

describe 'user signup' do
	it "users can sign up with valid email and password" do
		visit "/users/sign_up"

		fill_in "Email", 				 			:with => "test99@gmail.com"
		fill_in "user_password",				 	:with => "testing567"
		fill_in "user_password_confirmation", 		:with => "testing567"
		
		click_button "Sign up"

		expect(page).to have_content("Welcome! You have signed up successfully.")
	end

	it 'users cannot sign up with invalid password' do
		visit "/users/sign_up"

		fill_in "Email", 						 	:with => "test99@gmail.com"
		fill_in "user_password",				 	:with => "tes"
		fill_in "user_password_confirmation", 		:with => "tes"
		
		click_button "Sign up"

		expect(page).to have_content("minimum is 8 characters")
	end
end

describe "user login" do
	user = User.create(:email => "mrRight@gmail.com", :password => "imalwaysright")
	it "allows user to login successfully" do
		visit "/users/sign_in"

		fill_in "Email",							:with => "mrRight@gmail.com"
		fill_in "Password",							:with => "imalwaysright"

		click_button "Log in"

		expect(page).to have_content("Signed in successfully.")
	end
end