class AuctionsController < ApplicationController
  before_action :find_auction, only: [:edit, :update, :destroy, :show]

  DEFAULT_REWARD_COUNT = 2

  def new
    if user_signed_in?
      @auction = Auction.new
    else
      redirect_to new_user_session_path, alert:"Log in Please!"
    end
  end

  def create
    @auction = Auction.new(auction_params)
    @auction.user = current_user
    if @auction.save
      redirect_to(auction_path(@auction), notice: "Auction created!")
    else
      render :new
    end
  end

  def show
    @bid = Bid.new
  end

  def edit
    # if @campaign.user != current_user
      # redirect_to root_path, alert: "Access denied!"
    # end
  end

  def update
    # if @campaign.user != current_user
      # redirect_to root_path
    # elsif @campaign.update campaign_params
    if @auction.update auction_params
      redirect_to auction_path(@auction)
    else
      render :edit
    end
  end

  def index
    @auctions = Auction.all
    # respond_to do |format|
    #   format.html { render }
    #   format.json { render json: @campaigns.to_json }
    # end
  end

  def destroy
    @auction = Auction.find params[:id]
    @auction.destroy
    flash[:notice] = "Auction deleted Successfully."
    redirect_to auctions_path
  end

  private

  def find_auction
    @auction = Auction.find(params[:id])
  end

  def auction_params
    params.require(:auction).permit(:title, :reserve_price, :details, :end_date)
  end
end
