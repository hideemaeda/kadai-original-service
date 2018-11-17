class UsersController < ApplicationController
  before_action :require_user_logged_in, only: [:index, :show]  

  def index
    @users = User.all.page(params[:page])
  end
  
  def new
    @user = User.new
  end
  
  def create
    @user = User.new(user_params)

    if @user.save
      flash[:success] = 'ユーザを登録しました。'
      redirect_to @user
    else
      flash.now[:danger] = 'ユーザの登録に失敗しました。'
      render :new
    end
  end
  
  def show
    @user = User.find(params[:id])
  end
  
  def edit
    @user = User.find(params[:id])
  end
  
  def update
    @user = User.find(params[:id])

    if @user.update(user_params)
      flash[:success] = 'アカウント情報が更新されました'
      redirect_to @user
    else
      flash.now[:danger] = 'アカウント情報 は更新されませんでした'
      render :edit
    end
  end
  
  def destroy
    @user = User.find(params[:id])
    @user.destroy

    flash[:success] = 'アカウントは削除されました'
    redirect_to root_url
  end

  def correct_user
    @project = Project.find(params[:id])
    redirect_to root_path if @project.assign_users.include?(current_user)
  end

  def correct_task
    @task = Task.find(params[:id])
    redirect_to root_path if @task.task_menbers.include?(current_user)
  end

  private

  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end
end
