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
    tasks = []
    0.upto(params[:task][:name].size-1).each do |i|
      task          = Task.new()
      task.name     = params[:task][:name][i]
      task.user_id  = @user
      task.detail   = params[:task][:detail][i]
      task.limit    = Time.parse(params[:task][:limit][i]).to_datetime
      task.estimate = params[:task][:estimate][i]
      task.tmp_id   = params[:task][:tmp_id][i]
      tasks << task
    end

    Task.transaction do
      task_ids = []
      @position = Position.where(:user_id => @user).first || Position.new(user_id: @user)
      position_array = Rack::Utils.parse_nested_query(params[:position][:array])

      tasks.each do |task|
        task.save!
        @position.set(task.id, position_array["task"])
      end

      @position.save!
      raise
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
