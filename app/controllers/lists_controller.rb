class ListsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @list = List.new
  end

  def create
    @list = current_user.build_list(params[:list])
    if @list.save
      format.json { render json: @list, status: :created }
    else
      format.json { render json: @list.errors, status: :unprocessable_entity}
    end
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
