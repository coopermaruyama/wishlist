class LineItemsController < ApplicationController

  def index
  end

  def show
  end

  def new
    @lineitem = LineItem.new
  end

  def create
    @line_item = current_user.list.line_item.build params[:line_item]
    if @line_item.save
      format.json { render json: @list, status: :created }
    else
      format.json { render json: @list.errors, status: :unprocessable_entity}
    end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
