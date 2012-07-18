class HomeController < ApplicationController
  respond_to :json

  def index
  	if user_signed_in?
  		@user = current_user
  	end
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
end
