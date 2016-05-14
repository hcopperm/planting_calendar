class AddPlantedAtToPlantingTasks < ActiveRecord::Migration
  def change
    add_column :planting_tasks, :planted_at, :date
  end
end
