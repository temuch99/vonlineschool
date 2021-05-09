class CreateTeachersCourses < ActiveRecord::Migration[6.0]
  def change
    create_table :teachers_courses do |t|
    	t.timestamps
    end

    add_reference :teachers_courses, :user
    add_reference :teachers_courses, :course
  end
end
