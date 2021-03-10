class CreateOrders < ActiveRecord::Migration[6.0]
  def change
    create_table :orders do |t|
      t.string     :postal_code, null: false
      t.integer    :area_id,     null: false
      t.string     :city,        null: false
      t.string     :address,     null: false
      t.string     :building
      t.string     :phone_num,   null: false
      t.references :buyer,       foreign_key: true
      t.timestamps
    end
  end
end
