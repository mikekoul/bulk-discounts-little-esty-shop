class MerchantItemsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @item = Item.find(params[:item_id])
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    item = merchant.items.new(item_params)

    if item.save
      redirect_to "/merchants/#{merchant.id}/items"
    else
      redirect_to "/merchants/#{merchant.id}/items/new"
      flash[:alert] = "Error: #{error_message(item.errors)}"
    end
  end

  def edit
    @item = Item.find(params[:item_id])
  end

  def update
    item = Item.find(params[:item_id])

    if params[:enabled]
      item.update!(status: "Enabled")
      redirect_to "/merchants/#{item.merchant_id}/items"
    elsif params[:disabled]
      item.update!(status: "Disabled")
      redirect_to "/merchants/#{item.merchant_id}/items"

    elsif item.update(item_params)
      redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}"
      flash[:success] = "Update to #{item.name} was successful!"
    else
      redirect_to "/merchants/#{item.merchant_id}/items/#{item.id}/edit"
      flash[:alert] = "Error: #{error_message(item.errors)}"
    end
  end

  private

  def item_params
    params.permit(:name, :description, :unit_price, :status)
  end
end
