require "rails_helper"

RSpec.describe Instructor::CoursesController, :type => :controller do
	let(:course) { create(:course) }
	before { sign_in course.user }

	describe "POST#create" do
		context 'create a course' do
			it 'course is saved to db' do
				expect {
					post :create, :course => course.attributes
				}.to change(Course, :count).by(1)
				expect(assigns[:course].user_id).to eq(course.user.id)
			end
			it "course is not saved to db with empty title" do
				course[:title] = ""
				expect {
					post :create, :course => course.attributes
				}. to change(Course, :count).by(0)
				expect(assigns[:course].errors).not_to be_empty 
			end
		end
	end

	describe "User Permissions" do
		context "user did not create course" do
			it "user cannot access show page" do
				unauthorized_user = create(:user, email: "test2@gmail.com")
				sign_in unauthorized_user
				get :show, :id => course
				expect(response).to have_http_status(:unauthorized)
			end
		end
		context "user created course" do
			it "user can access show page" do
				get :show, :id => course
				expect(response).to have_http_status(:success)
			end
		end
	end
end
