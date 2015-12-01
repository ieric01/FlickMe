class EnrollmentsController < ApplicationController
	before_action :authenticate_user!

	def create
		@course = Course.find(course_params["course_id"])
		
		if @course.premium?
			# Amount in cents
		    @amount = (@course.cost * 100).to_i

		    customer = Stripe::Customer.create(
		      :email => current_user.email,
		      :card  => params[:stripeToken]
		    )

		    charge = Stripe::Charge.create(
		      :customer    => customer.id,
		      :amount      => @amount,
		      :description => 'FlickMe Enrolled Course',
		      :currency    => 'usd'
		    )
		end

		user_course_params = course_params.merge("user_id" => current_user.id)
		Enrollment.create(user_course_params)
 		redirect_to course_path(@course)

	    rescue Stripe::CardError => e
	    flash[:error] = e.message
	    redirect_to root_path
	end

	private

	def course_params
		params.permit(:course_id)
	end

end
