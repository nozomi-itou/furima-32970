class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:/, :new]


  #def index
    #@items = Item.includes(:user).order("created_at DESC")
  #end

  def new
    @item = Item.new
  end

  def create
    @item = Item.new(item_params)
    if @item.save
      redirect_to root_path(@item)
    else
      render :new
    end
  end

  private

  def item_params
    params.require(:item).permit(:name, :details, :category_id, :status_id, :postage_id, :area_id, :day_id, :price, :image).merge(user_id: current_user.id)
  end


end
