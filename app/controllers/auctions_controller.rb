class AuctionsController < ApplicationController
  before_action :find_auction, only: [:edit, :update, :destroy, :show]

  DEFAULT_REWARD_COUNT = 2

  def new
    @auction = Auction.new
  end

  def create
    # service = Campaigns::CreateCampaign.new(params: campaign_params,
    #                                         user:   current_user)
    # if service.call
    #   redirect_to campaign_path(service.campaign)
    # else
    #   @campaign = service.campaign
    #   number_to_build = DEFAULT_REWARD_COUNT - @campaign.rewards.size
    #   number_to_build.times { @campaign.rewards.build }
    #   render :new
    # end
    @auction = Auction.new(auction_params)
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
    # if current_user == @campaign.user
      @auction.destroy
      redirect_to campaigns_path
    # else
      # redirect_to root_path
    # end
  end

  private

  def find_auction
    @auction = Auction.find(params[:id])
  end

  def auction_params
    params.require(:auction).permit(:title, :reserve_price, :details, :end_date)
  end
end
