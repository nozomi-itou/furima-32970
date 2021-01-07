class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image

  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :postage
  belongs_to :area
  belongs_to :day

  with_options presence: true do

    validates :name 
    validates :details 
    validates :category_id
    validates :status_id
    validates :postage_id
    validates :area_id
    validates :day_id
    validates :image

  end

  validates :category_id, :status_id, :postage_id, :area_id, :day_id, numericality: { other_than: 1 } 

  validates  :price,  presence: true, format: {with: /\A[0-9]+\z/}, numericality: { only_integer: true,
    greater_than: 299, less_than: 10000000}
end
