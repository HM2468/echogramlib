class ApplicationController < ActionController::Base
  include SessionsHelper

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in first."
      redirect_to login_url
    end
  end

  def logged_in_admin
    if logged_in?
      unless current_user.admin
        flash[:danger] = "Please log in as an administrator."
        redirect_to login_url
      end
    else
      flash[:danger] = "Please log in first."
      redirect_to login_url
    end
  end  



end
