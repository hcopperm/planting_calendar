module PlantingTasksHelper
  def link_to_date(task_date)
    link_to task_date.strftime("%m/%d/%y"), root_path(scope: :planted_on, date: task_date)
  end

end
