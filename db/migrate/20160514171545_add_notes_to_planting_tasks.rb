class AddNotesToPlantingTasks < ActiveRecord::Migration
  def change
    add_column :planting_tasks, :notes, :text
  end
end
