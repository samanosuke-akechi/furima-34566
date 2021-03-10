require 'rails_helper'

RSpec.describe BuyerOrder, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.create(:item, user_id: @user.id)
    @buyer_order = FactoryBot.build(:buyer_order, user_id: @user.id, item_id: @item.id)
    sleep(0.1)
  end

  describe '商品購入機能' do
    context '商品の購入ができる時' do
      it '全ての情報があれば登録できる' do
        expect(@buyer_order).to be_valid
      end
      it 'buildingが空でも購入ができること' do
        @buyer_order.building = ""
        expect(@buyer_order).to be_valid
      end
    end
    
    context '商品が購入できない時' do
      it 'tokenが空だと保存できないこと' do
        @buyer_order.token = nil
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("Token can't be blank")
      end
      it 'postal_codeが空だと保存できないこと' do
        @buyer_order.postal_code = ""
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("Postal code can't be blank")
      end
      it 'postal_codeが-がない(数字のみ)と保存できないこと' do
        @buyer_order.postal_code = "1234567"
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeが`数字3文字 - 数字4文字`でないと保存できないこと' do
        @buyer_order.postal_code = "12-34567"
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeが全角数字では保存できないこと' do
        @buyer_order.postal_code = "１２３-４５６７"
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'postal_codeが数字以外では保存できないこと' do
        @buyer_order.postal_code = "abc-defg"
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("Postal code is invalid. Include hyphen(-)")
      end
      it 'area_idが空では保存できないこと' do
        @buyer_order.area_id = ""
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("Area can't be blank")
      end
      it 'area_idが0では保存できないこと' do
        @buyer_order.area_id = 0
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("Area Select")
      end
      it 'cityが空では保存できないこと' do
        @buyer_order.city = ""
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("City can't be blank")
      end
      it 'addressが空では保存できないこと' do
        @buyer_order.address = ""
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("Address can't be blank")
      end
      it 'phone_numが空では保存できないこと' do
        @buyer_order.phone_num = ""
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("Phone num can't be blank")
      end
      it 'phone_numが-を含んでいると保存できないこと' do
        @buyer_order.phone_num = "090-1234-5678"
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("Phone num is invalid. Do not include(-)")
      end
      it 'phone_numが11桁を超えると保存できないこと' do
        @buyer_order.phone_num = "090123456789"
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("Phone num is invalid. Do not include(-)")
      end
      it 'phone_numが全角数字だと保存できないこと' do
        @buyer_order.phone_num = "０９０１２３４５６７８"
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("Phone num is invalid. Do not include(-)")
      end
      it 'phone_numが半角英字を含むと保存できないこと' do
        @buyer_order.phone_num = "aaaaaaaaaa"
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("Phone num is invalid. Do not include(-)")
      end
      it 'user_idが空だと保存できないこと' do
        @buyer_order.user_id = ""
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("User can't be blank")
      end
      it 'item_idが空だと保存できないこと' do
        @buyer_order.item_id = ""
        @buyer_order.valid?
        expect(@buyer_order.errors.full_messages).to include("Item can't be blank")
      end
    end
  end
end