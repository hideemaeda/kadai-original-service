class ToppagesController < ApplicationController
  def index
    if logged_in?
      @project = current_user.projects.build  # form_for 用
      @projects = current_user.projects.order('created_at DESC').page(params[:page])
    end
  end
end
