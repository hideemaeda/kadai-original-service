class AssignMembersController < ApplicationController
  before_action :require_user_logged_in

  def create
    assign_member = AssignMember.new(assign_member_params)
    assign_member.save
    flash[:success] = 'メンバーをプロジェクトに登録しました。'
    redirect_back(fallback_location: root_path)
  end

  def destroy
    assign_member = AssignMember.find_by(pjmember_params)
    assign_member.destroy
    flash[:success] = 'メンバーをプロジェクトから外しました。'
    redirect_back(fallback_location: root_path)
  end
  
  private
  
  def assign_member_params
    params.require(:assign_member).permit(:user_id, :task_id)
  end
end
