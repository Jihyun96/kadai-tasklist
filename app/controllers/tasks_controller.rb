class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
  
  def index
    @tasks = Task.all.page(params[:page]).per(10)
  end
  def show
  end
  def new
    @task = Task.new
  end
  def create
    @task = current_user.tasks.new(task_params)
    if @task.save
      flash[:success] = 'タスクが正常に投稿されました。'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが正常に投稿されませんでした。'
      render :new
    end
  end
  def edit
  end
  def update
    if @task.update(task_params)
      flash[:success] = 'タスクが正常に更新されました。'
      redirect_to @task
    else
      flash.now[:danger] = 'タスクが正常に更新されませんでした。'
      render :edit
    end
  end
  def destroy
    @task.destroy
    flash[:success] = 'タスクが正常に削除されました'
    redirect_to root_url
  end
  
  private
  
  def set_task
    @task = current_user.tasks.find_by(id: params[:id])
  end
  def task_params
    params.require(:task).permit(:content, :status)
  end

  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end
end
