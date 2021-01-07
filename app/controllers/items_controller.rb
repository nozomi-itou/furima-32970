class ItemsController < ApplicationController
  before_action :authenticate_user!, only: [:new, :create]

  before_action :set_item, only: [:show, :edit, :update, :destroy]

  def index
    @items = Item.includes(:user).order("created_at DESC")
  end

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

  def show
  end

  def edit
    unless @item.user_id == current_user.id
      redirect_to action: :index
    end
  end

  def update
    if @item.update(item_params)
      redirect_to item_path
    else
      render :edit
    end
  end

  def destroy
    if @item.user_id == current_user.id
      @item.destroy
     end

    if @item.destroy
      redirect_to  root_path(@item)
    end
  end


  private

  def item_params
    params.require(:item).permit(:name, :details, :category_id, :status_id, :postage_id, :area_id, :day_id, :price, :image).merge(user_id: current_user.id)
  end


  def set_item
    @item = Item.find(params[:id])
  end

end
