class TasksController < ApplicationController
  before_action :set_task, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:show, :edit, :update, :destroy]
  
  def index
    @tasks = Task.all.page(params[:page])
  end
  
  def show
    @all_users = User.all.page(params[:page])
    @users = User.where.not(id: AssignMember.where(task_id: @task.id).pluck(:user_id))
    @taskmember = current_user.assign_members.build(task_id: @task.id)
    @taskmember_users = User.where(id: AssignMember.where(task_id: @task.id).pluck(:user_id))
  end
  
  def new
    @project = Project.find(params[:project_id])
    @task = Task.new
  end
  
  def create
    @project = Project.find(params[:project_id])
    @task = current_user.tasks.build(task_params)
    @task.project_id = @project.id
    
    if @task.save
      flash[:success] = 'タスクが正常に登録されました'
      redirect_back(fallback_location: root_path)
    else
      @tasks = current_user.tasks.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'タスクが登録されませんでした'
      render :new
    end
  end
  
  def edit
    @project = Project.find(params[:project_id])
    @task = current_user.tasks.find(params[:id])
    @task.project_id = @project.id
    @all_users = User.all.page(params[:page])
    @users = User.where.not(id: AssignMember.where(task_id: @task.id).pluck(:user_id))
    @taskmember = current_user.assign_members.build(task_id: @task.id)
    @taskmember_users = User.where(id: AssignMember.where(task_id: @task.id).pluck(:user_id))
  end
  
  def update
    @project = Project.find(params[:project_id])
    @task = current_user.tasks.find(params[:id])
    @task.project_id = @project.id
    
    if @task.update(task_params)
      flash[:success] = 'タスクが正常に更新されました'
      redirect_to project_path
    else
      flash.now[:danger] = 'タスクが更新されませんでした'
      render :new
    end
  end
  
  def destroy
    @project = Project.find(params[:project_id])
    @task = current_user.tasks.find_by(id: @task)
    @task.project_id = @project.id
    
    @task.destroy
    flash[:success] = 'タスクは正常に削除されました'
    redirect_to root_url
  end
  
  private

  def set_task
    @task = Task.find(params[:id])
  end
  
  def correct_user
    @task = current_user.tasks.find_by(id: params[:id])
    unless @task
      redirect_to root_url
    end
  end

  def task_params
    params.require(:task).permit(:title, :priority, :schedule, :progress, :alarm, :comment)
  end
end
