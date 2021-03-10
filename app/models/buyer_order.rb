class BuyerOrder
  include ActiveModel::Model
  attr_accessor :postal_code, :area_id, :city, :address, :building, :phone_num, :user_id, :item_id, :token

  with_options presence: true do
    validates :postal_code, format: {with: /\A[0-9]{3}-[0-9]{4}\z/, message: "is invalid. Include hyphen(-)"}
    validates :area_id, numericality: {other_than: 0, message: "Select"}
    validates :phone_num, format: {with: /\A\d{10,11}\z/, message: "is invalid. Do not include(-)"}
    validates :city, :address, :token, :user_id, :item_id  # Formオブジェクトではアソシエーションを組めないので、外部キーについてもpresence: trueが必要
  end

  def save
    buyer = Buyer.create(user_id: user_id, item_id: item_id)
    Order.create(postal_code: postal_code, area_id: area_id, city: city, address: address, building: building, phone_num: phone_num, buyer_id: buyer.id)
  end
end