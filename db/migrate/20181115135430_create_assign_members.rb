class CreateAssignMembers < ActiveRecord::Migration[5.0]
  def change
    create_table :assign_members do |t|
      t.references :user, foreign_key: true
      t.references :task, foreign_key: true

      t.timestamps
    end
  end
end
