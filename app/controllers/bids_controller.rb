class BidsController < ApplicationController
  def create
    if user_signed_in?
      @auction = Auction.find(params[:auction_id])
      @bid   = @auction.bids.new bid_params
      @bid.user = current_user
      @bid.auction = @auction
      # if @bid.save
      #   redirect_to auction_path(@auction), notice: "Please Bid"
      # else
      #   render "/auctions/show"
      # end
      respond_to do |format|
        if @bid.save
          format.html { redirect_to auction_path(@auction), notice: "Bid has been submitted successfully!" }
          format.js {render :create_success}
        else
          format.html { render "auctions/show "}
          format.js { render :create_failure }
        end
      end
    else
      redirect_to new_user_registration_path, alert:"Sign up Please"
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:bid_price)
  end
end
