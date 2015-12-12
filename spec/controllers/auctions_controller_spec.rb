require 'rails_helper'

RSpec.describe AuctionsController, type: :controller do

  let(:user){ FactoryGirl.create(:user) }

  describe "#new" do
    context "with user not signed in" do
      it "redirects to user sign in page" do
        get :new
        expect(response).to redirect_to(new_user_session_path)
      end
    end

    context "with user signed in" do
      before do
        @user = FactoryGirl.create(:user)
        sign_in :user, @user

        @request.env["devise.mapping"] = Devise.mappings[:user]
        get :new
      end

      it "renders the new template" do
        expect(response).to render_template(:new)
      end

      it "creates a new auction object assigned to 'auction' instance variable" do
        expect(assigns(:auction)).to be_a_new(Auction)
      end
    end
  end

  describe "#create" do
    context "with no user signed in" do
      it "redirects to the sign up page" do
        post :create, {auction: {title: "hi", reserve_price: "100", details: "adsklfjasdklf"}}
        expect(response).to redirect_to new_user_registration_path
      end
    end

    context "with user signed in" do
      def valid_params
        FactoryGirl.attributes_for(:auction)
      end

      before do
        @user = FactoryGirl.create(:user)
        sign_in :user, @user
      end

      context "with valid parameters" do
        it "creates an auction record in the database" do
          before_count = Auction.count
          post :create, auction: valid_params
          after_count = Auction.count
          expect(after_count - before_count).to eq(1)
        end

        it "associates the auction with the signed in user" do
          post :create, auction: valid_params
          expect(Auction.last.user).to eq(@user)
        end

        it "redirects to auction show page" do
          post :create, auction: valid_params
          expect(response).to redirect_to(auction_path(Auction.last))
        end
      end
    end
  end
end
