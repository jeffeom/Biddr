require 'rails_helper'

RSpec.describe BidsController, type: :controller do
  let(:user){ FactoryGirl.create(:user) }


  describe "#create" do

    context "with user not signed in" do

      before do
        @auction = FactoryGirl.build(:auction)
        @auction.save
        @auction_attributes = FactoryGirl.attributes_for(:auction)
        @bid_attributes = FactoryGirl.attributes_for(:bid, :article_id => @article)
      end

      it "Redirects to sign up page" do
        post :create, :auction_id => @auction, :bid => @bid_attributes
        expect(response).to redirect_to new_user_registration_path
      end
    end

    context "with user signed in" do

      before do
        @user = FactoryGirl.create(:user)
        sign_in :user, @user

        @auction = FactoryGirl.build(:auction)
        # @auction.user_id = @user.id
        @auction.save

        @auction_attributes = FactoryGirl.attributes_for(:auction)
        @bid_attributes = FactoryGirl.attributes_for(:bid, :article_id => @article)
      end

      it "Does not create a bid record in the database if the user is same as the auction user" do
        expect(Bid.count).to eq(0)
      end

      it "Create a bid record in the database if the user is a different user" do
        before_count = Bid.count
        post :create, :auction_id => @auction, :bid => @bid_attributes
        after_count = Bid.count
        expect(after_count - before_count).to eq(1)
      end

      it "associates the bid with the signed in user" do
        post :create, :auction_id => @auction, :bid => @bid_attributes
        expect(Bid.last.user).to eq(@user)
      end

      it "redirects to auction show page" do
        post :create, :auction_id => @auction, :bid => @bid_attributes
        expect(response).to redirect_to(auction_path(@auction))
      end
    end
  end
end
  #
  #   context "with user signed in" do
  #     def valid_params
  #       FactoryGirl.attributes_for(:auction)
  #     end
  #
  #     before do
  #       @user = FactoryGirl.create(:user)
  #       sign_in :user, @user
  #     end
  #
  #     context "with valid parameters" do
  #       it "creates an auction record in the database" do
  #         before_count = Auction.count
  #         post :create, auction: valid_params
  #         after_count = Auction.count
  #         expect(after_count - before_count).to eq(1)
  #       end
  #
  #       it "associates the auction with the signed in user" do
  #         post :create, auction: valid_params
  #         expect(Auction.last.user).to eq(@user)
  #       end
  #
  #       it "redirects to auction show page" do
  #         post :create, auction: valid_params
  #         expect(response).to redirect_to(auction_path(Auction.last))
  #       end
  #     end
  #   end
  # end
# end
