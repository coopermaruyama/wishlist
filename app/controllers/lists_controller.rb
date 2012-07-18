class ListsController < ApplicationController
  respond_to :json
  def index
  end

  def show
    respond_with current_user.list
  end

  def new
    @list = current_user.build_list
  end

  def create
    @list = current_user.build_list(params[:list])
    @list.save
    # if @list.save
    #   format.json { render json:  @list, status: :created }
    # else
    #   format.json { render json: @list.errors, status: :unprocessable_entity}
    # end
  end

  def edit
    @list = List.find(params[:list])
  end

  def update
    @list = List.find(params[:list])
    if @list.update_attributes params[:list]
      format.json { head :no_content }
    else
      format.json { render json @list.errors, status: :unprocessable_entity }
    end
  end

  def destroy
    # TODO cookie support
  end

end
