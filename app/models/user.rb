class User < ActiveRecord::Base

  has_many :bids, dependent: :nullify
  has_many :auctions, dependent: :destroy
  
  validates :email, presence: true,
            format:{ with: /\A[^@\s]+@([^@\s]+\.)+[^@\s]+\z/ }
  validates :first_name, presence: true
  validates :last_name, presence: true

end
