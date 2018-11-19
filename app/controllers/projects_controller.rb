class ProjectsController < ApplicationController
  before_action :set_project, only: [:show, :edit, :update, :destroy]
  before_action :require_user_logged_in
  before_action :correct_user, only: [:destroy]
 
  def index
    @projects = Project.all.page(params[:page])
  end
  
  def show
    @users = User.where.not(id: Pjmember.where(project_id: @project.id).pluck(:user_id))
    @pjmember = current_user.pjmembers.build(project_id: @project.id)
    @pjmember_users = User.where(id: Pjmember.where(project_id: @project.id).pluck(:user_id))
    @tasks = Task.all.page(params[:page])
    @task = @project.tasks.find_by(project: @task)
  end

  def new
    @project = Project.new
  end

  def create
    @project = current_user.projects.build(project_params)
    if @project.save
      flash[:success] = 'プロジェクトを作成しました。'
      redirect_to root_url
    else
      @projects = current_user.assign_projects.order('created_at DESC').page(params[:page])
      flash.now[:danger] = 'プロジェクトの作成に失敗しました。'
      render 'toppages/index'
    end
  end
  
  def edit
    @all_users = User.all.page(params[:page])
    @users = User.where.not(id: Pjmember.where(project_id: @project.id).pluck(:user_id))
    @pjmember = current_user.pjmembers.build(project_id: @project.id)
    @pjmember_users = User.where(id: Pjmember.where(project_id: @project.id).pluck(:user_id))
  end
  
  def update
    if @project.update(project_params)
      flash[:success] = 'プロジェクト情報が更新されました'
      redirect_to @project
    else
      flash.now[:danger] = 'プロジェクト情報は更新されませんでした'
      render :edit
    end
  end

  def destroy
    @project.destroy
    flash[:success] = 'プロジェクトを削除しました。'
    redirect_to root_url
  end

  private

  def set_project
    @project = Project.find(params[:id])
  end

  def project_params
    params.require(:project).permit(:title, :comment, :start_day, :end_day)
  end

  def correct_user
    @project = current_user.projects.find(params[:id])
  end
end
