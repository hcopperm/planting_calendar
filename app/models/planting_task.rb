class PlantingTask < ActiveRecord::Base
  scope :unplanted,   -> { where(planted_at: nil) }
  scope :unharvested, -> { where(completed: nil) }
  scope :planted,     -> { where.not(planted_at: nil) }
  scope :harvested,   -> { where.not(completed: nil) }
  scope :planted_on,  -> (date) { where(planted_at: date) }
  # all crops for this week, planted already or not
  scope :this_week,   -> { where('ideal_planting_date <= ?', Date.today + 1.week).
                           where('ideal_planting_date >= ?', Date.today )
                         }
  # all crops for today, planted already or not
  scope :today,       -> { where(ideal_planting_date: Date.today) }
  scope :planting_overdue, -> { where(planted_at: nil).where('ideal_planting_date < ?', Date.today) }
  scope :planting_soon,    -> { where(planted_at: nil).
                                where('ideal_planting_date > ?', Date.today).
                                where('ideal_planting_date <= ?', Date.today + 5.days)
                              }

end
