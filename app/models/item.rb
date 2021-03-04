class Item < ApplicationRecord
  belongs_to :user
  has_one_attached :image
  
  extend ActiveHash::Associations::ActiveRecordExtensions
  belongs_to :category
  belongs_to :status
  belongs_to :burden
  belongs_to :area
  belongs_to :days


  with_options presence: true do
    validates :name, :description, :image
    validates :price, numericality: {only_integer: true, greater_than_or_equal_to: 300, less_than_or_equal_to: 9999999, message: 'is invalid'}
  end
  with_options numericality: {other_than: 0} do
    validates :category_id, :status_id, :burden_id, :area_id, :days_id
  end

end