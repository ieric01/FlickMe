class EnrollmentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@course = Course.find(course_params["course_id"])
		user_course_params = course_params.merge("user_id" => current_user.id)
		Enrollment.create(user_course_params)
		redirect_to course_path(@course)
	end

	private

	def course_params
		params.permit(:course_id)
	end

end
