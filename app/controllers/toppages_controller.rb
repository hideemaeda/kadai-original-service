class ToppagesController < ApplicationController
  def index
    if logged_in?
      @projects = current_user.projects.order('created_at DESC').page(params[:page])
    end
  end
end
