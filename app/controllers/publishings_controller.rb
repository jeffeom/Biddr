class PublishingsController < ApplicationController
  def create
    auction = Auction.find params[:auction_id]
    if auction.publish
      auction.save
      redirect_to auction, notice: "Auction Published!"
    else
      redirect_to auction, alert: "Error! Can't publish auction."
    end
  end
end
