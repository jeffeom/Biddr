class BidsController < ApplicationController
  def create
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
  end

  private

  def bid_params
    params.require(:bid).permit(:bid_price)
  end
end
