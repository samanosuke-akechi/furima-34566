require 'rails_helper'

RSpec.describe Item, type: :model do
  before do
    @user = FactoryBot.create(:user)
    @item = FactoryBot.build(:item, user_id: @user.id)
  end

  describe '商品出品機能' do
    context '商品情報が登録できる時' do
      it 'すべての情報があれば登録できる' do
        expect(@item).to be_valid
      end
    end

    context '商品情報が登録できない時' do
      it 'imageが空だと保存できないこと' do
        @item.image = nil
        @item.valid?
        expect(@item.errors.full_messages).to include("Image can't be blank")
      end
      it 'nameが空だと保存できないこと' do
        @item.name = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Name can't be blank")
      end
      it 'descriptionが空だと保存できないこと' do
        @item.description = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Description can't be blank")
      end
      it 'category_idが0(空)だと保存できないこと' do
        @item.category_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Category Select")
      end
      it 'status_idが0(空)だと保存できないこと' do
        @item.status_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Status Select")
      end
      it 'burden_idが0(空)だと保存できないこと' do
        @item.burden_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Burden Select")
      end
      it 'area_idが0(空)だと保存できないこと' do
        @item.area_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Area Select")
      end
      it 'days_idが0(空)だと保存できないこと' do
        @item.days_id = 0
        @item.valid?
        expect(@item.errors.full_messages).to include("Days Select")
      end
      it 'priceが空だと保存できないこと' do
        @item.price = ''
        @item.valid?
        expect(@item.errors.full_messages).to include("Price can't be blank")
      end
      it 'priceが300未満だと保存できないこと' do
        @item.price = 299
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid")
      end
      it 'priceが9999999より大きいと保存できないこと' do
        @item.price = 10000000
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid")
      end
      it 'priceが全角だと保存できないこと' do
        @item.price = "５００"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid")
      end
      it 'priceが半角英数字混合だと保存できないこと' do
        @item.price = "2000yen"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid")
      end
      it 'priceが半角英字だと保存できないこと' do
        @item.price = "okane"
        @item.valid?
        expect(@item.errors.full_messages).to include("Price is invalid")
      end
    end
  end
end