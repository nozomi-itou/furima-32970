require 'rails_helper'

RSpec.describe Item, type: :model do
  describe '#create' do
    before do
      @item = FactoryBot.build(:item)
    end

    it "nameが空では登録できないこと" do
      @item.name = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Name can't be blank")
    end

    it "商品画像が無いと登録できない" do
      @item.image = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Image can't be blank")
    end

    it "商品説明が無いと登録できない" do
      @item.details = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Details can't be blank")
    end

    it "カテゴリー情報がないと登録できない" do
      @item.category_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Category can't be blank")
    end

    it "商品の状態についての情報がないと登録できない" do
      @item.status_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Status can't be blank")
    end

    it "配送料負担についての情報がないと登録できない" do
      @item.postage_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Postage can't be blank")
    end

    it "発送元の情報がないと登録できない" do
      @item.area_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Area can't be blank")
    end

    it "発送までの日数がないと登録できない" do
      @item.day_id = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Day can't be blank")
    end


    it "カテゴリー情報を(1以外)選択しないと登録できない" do
      @item.category_id = "1"
      @item.valid?
      expect(@item.errors.full_messages).to include("Category must be other than 1")
    end

    it "商品の状態についての情報を(1以外)選択しないと登録できない" do
      @item.status_id = "1"
      @item.valid?
      expect(@item.errors.full_messages).to include("Status must be other than 1")
    end

    it "配送料負担についての情報を(1以外)選択しないと登録できない" do
      @item.postage_id = "1"
      @item.valid?
      expect(@item.errors.full_messages).to include("Postage must be other than 1")
    end

    it "発送元の情報を(1以外)選択しないと登録できない" do
      @item.area_id = "1"
      @item.valid?
      expect(@item.errors.full_messages).to include("Area must be other than 1")
    end

    it "発送までの日数を(1以外)選択しないと登録できない" do
      @item.day_id = "1"
      @item.valid?
      expect(@item.errors.full_messages).to include("Day must be other than 1")
    end

    it "価格が無いと登録できない" do
      @item.price = nil
      @item.valid?
      expect(@item.errors.full_messages).to include("Price can't be blank")
    end

    it "価格の範囲が、¥300未満だと登録できない" do
      @item.price = "299"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be greater than 299")
    end

    it "価格の範囲が、¥10,000,000以上だと登録できない" do
      @item.price = "10000000"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price must be less than 10000000")
    end

    it "販売価格は全角では登録できない" do
      @item.price = "１００００"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end

    it "販売価格は半角英数混合では登録できない" do
      @item.price = "1111a"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end

    it "販売価格は半角英語では登録できない" do
      @item.price = "gleenday"
      @item.valid?
      expect(@item.errors.full_messages).to include("Price is not a number")
    end

    it "必要な情報を適切に入力すると、商品の出品ができる" do
      expect(@item).to be_valid
    end

  end
end