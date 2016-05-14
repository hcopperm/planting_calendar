class CreatePlantingTasks < ActiveRecord::Migration
  def change
    create_table :planting_tasks do |t|
      t.string :name
      t.date :completed
      t.date :due

      t.timestamps null: false
    end
  end
end
