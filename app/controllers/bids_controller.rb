class BidsController < ApplicationController
  def create
    @auction = Auction.find(params[:auction_id])
    @bid   = @auction.bids.new bid_params
    if @bid.save
      redirect_to auction_path(@auction), notice: "Please Bid"
    else
      render "/auctions/show"
    end
  end

  private

  def bid_params
    params.require(:bid).permit(:bid_price)
  end
end
