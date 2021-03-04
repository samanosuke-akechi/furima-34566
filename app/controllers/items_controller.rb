class ItemsController < ApplicationController
  def index
  end

  def new
    @item = Item.new
  end
  
  def create
    @item = Item.create
  end
end