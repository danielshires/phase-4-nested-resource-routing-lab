class ItemsController < ApplicationController
  rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response

  def index
    if params[:user_id]
      user = User.find(params[:user_id])
      items = user.items
    else
      items = Item.all
    end
    render json: items, include: :user
  end

  def show
    items = Item.find(params[:id])
    render json: items
  end 

  def create
    item = Item.create!(permit_params)
    render json: item, status: :created
  end

  private

  def render_not_found_response
    render json: {error: "Record not found"}, status: :not_found
  end

  def permit_params
    params.permit(:name, :description, :price, :user_id, :item)
  end


end
