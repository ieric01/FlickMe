require "rails_helper"

RSpec.describe Instructor::CoursesController, :type => :controller do
	describe "user sign in" do
		before(:each) do
			@user = create(:user)
			sign_in @user
		end
		describe "POST#create" do
			context 'create a course' do
				it 'course is saved to db' do
					course_params = attributes_for(:course)
					expect {
						post :create, :course => course_params
					}.to change(Course, :count).by(1)
					expect(assigns[:course].user_id).to eq(@user.id)
				end
				it "course is not saved to db with empty title" do
					course_params = attributes_for(:course)
					course_params[:title] = ""
					expect {
						post :create, :course => course_params
					}. to change(Course, :count).by(0)
					expect(assigns[:course].errors).not_to be_empty 
				end
			end
		end
	end
	describe 'user_with_course sign in' do
		before(:each) do
			@user = create(:user, :courses => [create(:course)])
			sign_in @user
			@course = @user.courses.first 
		end
		describe "User Permissions" do
			context "user did not create course" do
				it "user cannot access show page" do
					unauthorized_user = create(:user, email: "test2@gmail.com")
					sign_in unauthorized_user
					get :show, :id => (@course)
					expect(response).to have_http_status(:unauthorized)
				end
			end
			context "user created course" do
				it "user can access show page" do
					get :show, :id => (@course)
					expect(response).to have_http_status(:success)
				end
			end
		end
	end
end
