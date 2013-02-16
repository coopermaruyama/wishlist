class HomeController < ApplicationController
  respond_to :json

  def index
    unless cookies[:visited].present? and cookies[:visited] == "2"
      cookies.permanent[:visited] = {:value => "1", :path => "/"}
      redirect_to "/splash.html"
    end

  	if user_signed_in?
  		@user = current_user
  	end
    # if user_signed_in? and @user.list
    #   redirect_to "/lists/#{@user.list.id}"
    # end
  end

  def currentuser
    if user_signed_in?
      @user = User.find(current_user.id)
    else
      @user = false
    end

	respond_to do |format|
    	format.html # show.html.erb
    	format.json { render json: @user }
    end
  end

  def about
  end

  def privacy
    
  end
end
