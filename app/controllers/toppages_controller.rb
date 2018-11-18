class ToppagesController < ApplicationController
  def index
    if logged_in?
      @as_projects = current_user.assign_projects.order('created_at DESC').page(params[:page])
      @projects = current_user.projects.order('created_at DESC').page(params[:page])
    end
  end
end
