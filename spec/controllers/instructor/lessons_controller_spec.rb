require "rails_helper"

RSpec.describe Instructor::LessonsController, :type => :controller do
	let(:lesson) { create(:lesson) }
	before {sign_in lesson.section.course.user}

	describe "POST#create" do
		context "creating a lesson" do
			it "lesson saves to db" do
				expect {
					post :create, :section_id => lesson.section, 
								  :lesson => lesson.attributes
				}.to change(Lesson, :count).by(1)
			end
		end
		context "user who did not create course cannot create lesson" do
			it "unauthorized message" do
				user = create(:user)
				sign_in user
				expect {
					post :create, :section_id => lesson.section,
								  :lesson => lesson.attributes
				}.to change(Lesson, :count).by(0)
				expect(response).to have_http_status(:unauthorized)
			end
		end
	end
	describe "GET#new" do
		context "user who created course can make new lesson" do
			it "gets lesson form" do
				get :new, :section_id => lesson.section
				expect(response).to have_http_status(:success)
				expect(response).to render_template("new")
			end
		end
		context "user did not create course can not make a new lesson" do
			it "gets lesson form" do
				user = create(:user)
				sign_in user
				get :new, :section_id => lesson.section
				expect(response).to have_http_status(:unauthorized)
			end
		end
	end
end