class CreateProjects < ActiveRecord::Migration[5.0]
  def change
    create_table :projects do |t|
      t.string :title
      t.text :comment
      t.date :start_day
      t.date :end_day
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
