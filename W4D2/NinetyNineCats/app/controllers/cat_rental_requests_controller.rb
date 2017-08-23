class CatRentalRequestsController < ApplicationController

  def new
    @request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @request = CatRentalRequest.new(cat_rental_request_params)
    if @request.save
      redirect_to cat_url(@request.cat)
    else
      flash.now[:errors] = @request.errors.full_messages
      render :new, status: 422
    end
  end



  # def approve
  #
  # end

  private
  def cat_rental_request_params
    params.require(:cat_rental_request).permit(:cat_id, :start_date, :end_date, :status)
  end

  # def current_cat
    # Cat.find
  # end
end
