class LineItemsController < ApplicationController
  respond_to :json
  def index
    respond_with current_user.list.line_items.all
  end

  def show
  end

  def new
    @lineitem = LineItem.new
  end

  def create
    @line_items = current_user.list.line_items.build params[:line_item]
    @line_items.save
    # if @line_item.save
    #   format.json { render json: @list, status: :created }
    # else
    #   format.json { render json: @list.errors, status: :unprocessable_entity}
    # end
  end

  def edit
  end

  def update
  end

  def destroy
  end
end
