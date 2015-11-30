class User < ActiveRecord::Base
  has_many :courses
  has_many :enrolled_courses, :through => :enrollments, :source => :course
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable
  def enrolled_in?(course)
  	return false if course.enrollments.where(:user_id => self.id).empty?
  	return true
  end
end
