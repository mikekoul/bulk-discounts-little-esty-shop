class MerchantBulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def show
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:bulk_discount_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.new(bulk_params) 
    discount.save
    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  def edit
    @merchant = Merchant.find(params[:merchant_id])
    @bulk_discount = BulkDiscount.find(params[:bulk_discount_id])
  end

  def update
    merchant = Merchant.find(params[:merchant_id])
    discount = BulkDiscount.find(params[:bulk_discount_id])
    discount.update!(bulk_params)
    redirect_to "/merchants/#{merchant.id}/bulk_discounts/#{discount.id}"
  end

  def destroy
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.find_by(params[:id])
    discount.destroy
    redirect_to "/merchants/#{merchant.id}/bulk_discounts"
  end

  private
    def bulk_params
      params.permit(:name, :threshold, :percent_discount)
    end
end