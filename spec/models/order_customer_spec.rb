require 'rails_helper'

RSpec.describe OrderCustomer, type: :model do
  describe '購入情報の保存' do
    before do
      @order_customer = FactoryBot.build(:order_customer)
    end

    it 'すべての値が正しく入力されていれば保存できること' do
      expect(@order_customer).to be_valid
    end

    it 'post_code_idが空だと保存できないこと' do
      @order_customer.post_code_id = nil
      @order_customer.valid?
      expect(@order_customer.errors.full_messages).to include("Post code can't be blank")
    end

    it 'postal_codeが半角のハイフンを含んだ正しい形式でないと保存できないこと' do
      @order_customer.post_code_id = '1234567'
      @order_customer.valid?
      expect(@order_customer.errors.full_messages).to include("Post code is invalid. Include hyphen(-)")
    end

    it 'areaを選択していないと保存できないこと' do
      @order_customer.area_id = 1
      @order_customer.valid?
      expect(@order_customer.errors.full_messages).to include("Area can't be blank")
    end

    it 'cityが空だと保存できないこと' do
      @order_customer.city = nil
      @order_customer.valid?
      expect(@order_customer.errors.full_messages).to include("City can't be blank")
    end

    it "cityが全角（漢字・ひらがな・カタカナ）以外は登録できない" do
      @order_customer.city = 'ﾖｺﾊﾏｼ'
      @order_customer.valid?
      expect(@order_customer.errors.full_messages).to include("City is invalid. Input full-width characters.")
    end

    it 'addressが空だと保存できないこと' do
      @order_customer.address = nil
      @order_customer.valid?
      expect(@order_customer.errors.full_messages).to include("Address can't be blank")
    end

    it 'building_nameは空でも保存できること' do
      @order_customer.building_name = nil
      expect(@order_customer).to be_valid
    end
 
    it 'phone_numberが空だと保存できないこと' do
      @order_customer.phone_number = nil
      @order_customer.valid?
      expect(@order_customer.errors.full_messages).to include("Phone number can't be blank")
    end

    it 'phone_numberが全角数字だと保存できないこと' do
      @order_customer.phone_number = '０９０１２３４５６７８'
      @order_customer.valid?
      expect(@order_customer.errors.full_messages).to include("Phone number is invalid.")
    end

    it 'tokenが空だと保存できないこと' do
      @order_customer.token = nil
      @order_customer.valid?
      expect(@order_customer.errors.full_messages).to include("Token can't be blank")
    end

  end
end