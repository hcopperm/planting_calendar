class AddAttachmentPhotoToPlantingTasks < ActiveRecord::Migration
  def self.up
    change_table :planting_tasks do |t|
      t.attachment :photo
    end
  end

  def self.down
    remove_attachment :planting_tasks, :photo
  end
end
