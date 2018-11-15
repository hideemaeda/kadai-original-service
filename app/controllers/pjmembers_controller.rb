class PjmembersController < ApplicationController
  before_action :require_user_logged_in

  def create
    pjmember = Pjmember.new(pjmember_params)
    pjmember.save
    flash[:success] = 'メンバーをプロジェクトに登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    pjmember.destroy
    flash[:success] = 'メンバーをプロジェクトから外しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def pjmember_params
    params.require(:pjmember).permit(:user_id, :project_id)
  end
end
