class MerchantBulkDiscountsController < ApplicationController

  def index
    @merchant = Merchant.find(params[:merchant_id])
  end

  def new
    @merchant = Merchant.find(params[:merchant_id])
  end

  def create
    merchant = Merchant.find(params[:merchant_id])
    discount = merchant.bulk_discounts.new(bulk_params) 

    if discount.save
      flash.clear
      redirect_to "/merchants/#{merchant.id}/bulk_discounts"
    else
      redirect_to "/merchants/#{merchant.id}/bulk_discounts/new"
      flash[:alert] = "Error: Fields May Not Be Empty"
    end
  end

  private
    def bulk_params
      params.permit(:name, :threshold, :percent_discount)
    end

end