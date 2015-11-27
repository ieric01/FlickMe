require "rails_helper"

RSpec.describe Instructor::CoursesController, :type => :controller do
	describe "POST#create" do
		context 'create a course' do
			it 'course is saved to db' do
				user = create(:user) #factory girl syntax method
				sign_in user #devise test_helper
				course_params = attributes_for(:course)
				expect {
					post :create, :course => course_params
				}.to change(Course, :count).by(1)
				expect(assigns[:course].user_id).to eq(user.id)
			end
		end
			it "course is not saved to db with empty title" do
				user = create(:user)
				current_user = sign_in user #devise test_helper
				course_params = attributes_for(:course)
				course_params[:title] = ""
				expect {
					post :create, :course => course_params
				}. to change(Course, :count).by(0)

			end
	end
end

