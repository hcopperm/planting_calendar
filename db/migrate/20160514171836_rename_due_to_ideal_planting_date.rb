class RenameDueToIdealPlantingDate < ActiveRecord::Migration
  def change
    rename_column :planting_tasks, :due, :ideal_planting_date
  end
end
