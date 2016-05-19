class PlantingTasksController < ApplicationController

  before_action :load_task, only: [:edit, :update, :destroy]

  def filtered_index
    @tasks = PlantingTask.all
    if params[:scope]
      if params[:date]
        @tasks = PlantingTask.send(params[:scope], params[:date])
        @date = params[:date]
      else
        @tasks = PlantingTask.send(params[:scope])
      end
      @scope = params[:scope]
    end
    @scopes = scope_filters
  end

  def new
    @task = PlantingTask.new
    render :show_form
  end

  def create
    @task = PlantingTask.create(parsed_date_params)
    redirect_to root_path
  end

  def edit
    render :show_form
  end

  def update
    @task.update(parsed_date_params)
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

  def parsed_date_params
    date_params = [:ideal_planting_date, :planted_at, :completed]
    new_params = task_params
    date_params.each do |param|
      if new_params[param]
        new_date = Date.strptime(new_params[param], "%m/%d/%Y")
        new_params.delete(param)
        new_params[param] = new_date
      end
    end
    new_params
  end

  def scope_filters
    [:unplanted,
     :unharvested,
      :planted,
      :harvested,
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
