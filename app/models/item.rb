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
    validates :name, :description, :price
  end
  with_options numericality: {other_than: 0} do
    validates :category_id, :status_id, :burden_id, :area_id, :days_id
  end

end