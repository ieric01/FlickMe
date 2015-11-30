class AddIndexexToEnrollments < ActiveRecord::Migration
  def change
  	add_index :enrollments, [:user_id, :course_id]
  	add_index :enrollments, :course_id
  end
end

