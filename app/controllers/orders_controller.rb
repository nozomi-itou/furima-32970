class OrdersController < ApplicationController
  before_action :authenticate_user!, only: [:index, :create]
  before_action :set_item, only: [:index, :create]
  before_action :move_to_index, only: [:index, :create]
  
  def index
    @order_customer = OrderCustomer.new
  end
  
  def create
    
    @order_customer = OrderCustomer.new(order_params) 
    if @order_customer.valid?
      pay_item
      @order_customer.save
      return redirect_to root_path
    else
      render action: :index
    end
  end

  private


  def order_params
    params.require(:order_customer).permit(:post_code_id, :area_id, :city, :address, :building_name, :phone_number).merge(token: params[:token], user_id: current_user.id, item_id: params[:item_id])
  end

  def pay_item
    Payjp.api_key = ENV["PAYJP_SECRET_KEY"]  
    Payjp::Charge.create(
      amount: @item.price,
      card: order_params[:token],
      currency: 'jpy'
    )
  end

  def set_item
    @item = Item.find(params[:item_id])
  end

  def move_to_index
    if @item.order.present?
      redirect_to root_path
    end 
  end

end
