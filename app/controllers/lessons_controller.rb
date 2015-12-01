class LessonsController < ApplicationController
	before_action :authenticate_user!
	before_action :enrolled_in_course?

	def show
	end

	private
	helper_method :current_lesson

	def current_lesson
		@current_lesson ||= Lesson.find(params[:id])
	end

	def enrolled_in_course?
		course = current_lesson.section.course
		unless current_user.enrolled_in?(course)
			redirect_to course_path(course),
			:alert => "You have not enrolled in the course!"
		end
	end

end
