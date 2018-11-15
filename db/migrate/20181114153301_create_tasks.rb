class CreateTasks < ActiveRecord::Migration[5.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.string :priority
      t.date :schedule
      t.integer :progress, limit: 1
      t.string :alarm
      t.text :comment
      t.references :project, foreign_key: true

      t.timestamps
    end
  end
end
