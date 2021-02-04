class ModifyTeacherCreatedAttribute < ActiveRecord::Migration[6.0]
  def change
    change_column(:tests, :teacher_created, :string, :default => nil)
  end
end
