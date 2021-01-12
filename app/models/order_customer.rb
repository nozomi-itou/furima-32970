class OrderCustomer
  include ActiveModel::Model
  attr_accessor :post_code_id, :area_id, :city, :address, :building_name, :phone_number, :item_id, :user_id, :token, :order_id


  with_options presence: true do
    validates :post_code_id, format: { with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)" }
    validates :city, format: { with: /\A[ぁ-んァ-ン一-龥]/, message: "is invalid. Input full-width characters." }
    validates :address
    validates :phone_number, numericality: { with: /\A[0-9]\z/, message: "is invalid." }
  end

  validates :area_id, numericality: { other_than: 1, message: "can't be blank" }

  validates :token, presence: true

  def save
    
    order = Order.create(item_id: item_id, user_id: user_id)

    Customer.create(post_code_id: post_code_id, area_id: area_id, city: city, address: address,building_name: building_name, phone_number: phone_number, order_id: order.id)

  end
end
