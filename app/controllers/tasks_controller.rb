class TasksController < ApplicationController

  before_filter :set_user

  def index
    @tasks = Task.sort_by_position(@user)
  end

  def add
    @task = Task.new
    @defined_tasks = Task.sort_by_position(@user)
  end

  def create
    @task = Task.new(new_task_params)
    @task.user_id = @user
    @task.limit = Time.parse(params[:task][:limit]).to_datetime
    Task.transaction do
      @task.save!

      @position = Position.where(:user_id => @user).first || Position.new(user_id: @user)
      position_array = Rack::Utils.parse_nested_query(params[:position][:array])
      @position.set(@task.id, position_array["task"])
      @position.save!
    end
    redirect_to :action => :index
  end

  def edit
  end

  def divide
  end

  def remove
  end

  def finish
    finishing_task = Task.find(params[:task_id])
    finishing_task.finished = true

    result = (finishing_task.save ? {result: 1} : {result: 0})

    render :json => result
  end

  private
  def new_task_params
    params.require(:task).permit(:name, :detail, :estimate)
  end

  def set_user
    @user = 1
  end
end
