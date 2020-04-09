class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  # ログインしないとタスク表示されない
  before_action :require_user_logged_in, only: [:index, :show, :edit, :update, :destroy]
  before_action :current_user
  
  

  def index
    # @tasks=Task.all
    if logged_in?
      @tasks = current_user.tasks.order(id: :desc).page(params[:page])
    end
    # @tasks = current_user.tasks.order(id: :desc).page(params[:page])
  end
  
  def show
  end
  
  def new
    
    
    @task=Task.new
  end
  
  def create
    # @task=Task.new(task_params)
    @task = current_user.tasks.build(task_params)
    if @task.save
      flash[:success]='タスクが正常に追加されました'
      redirect_to @task
    else
      flash[:danger]='タスクが追加されませんでした'
      render :new
    end
  end
  
  def edit
    
  end
  
  def update
    
    
    if @task.update(task_params)
      flash[:success]='タスクは正常に更新されました'
      redirect_to @task
    else
      flash[:danger]='タスクは更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    
    @task.destroy
    
    flash[:success]='タスクは正常に削除されました'
    redirect_to tasks_url
  end
  
  private
  
  def set_task
    if logged_in?
      @task = current_user.tasks.find_by(id: params[:id])
      unless @task
        redirect_to root_url
      end
    else
      @task=Task.find(params[:id])
    end
  end
  
  def task_params
    params.require(:task).permit(:content, :status)
  end
  
end
