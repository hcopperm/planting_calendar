class PlantingTasksController < ApplicationController

  before_action :load_task, only: [:edit, :update, :destroy]

  def filtered_index
    @tasks = PlantingTask.all
    @tasks = PlantingTask.send(params[:scope]) if params[:scope]

    @scopes = scope_filters
  end

  def new
    @task = PlantingTask.new
    render :show_form
  end

  def create
    @task = PlantingTask.create(task_params)
    redirect_to root_path
  end

  def edit
    render :show_form
  end

  def update
    @task.update(task_params)
    redirect_to root_path
  end

  def destroy
    @task.destroy!
    redirect_to root_path
  end

  private

  def task_params
    params.require(:planting_task).permit(
      :name,
      :ideal_planting_date,
      :planted_at,
      :completed,
      :notes
    )
  end

  def scope_filters
    [:unplanted,
     :unharvested,
      :planted,
      :harvested,
      :planted_on,
      :this_week,
      :today,
      :planting_overdue,
      :planting_soon
    ]
  end

  def load_task
    @task ||= PlantingTask.find(params[:id])
  end
end
