class Auction < ActiveRecord::Base
  belongs_to :user

  has_many :bids, dependent: :destroy

  validates :title, presence: true
  validates :reserve_price, presence: true, numericality: {greater_than: 10}

  include AASM

  aasm whiny_transitions: false do
    state :draft, initial: true
    state :published
    state :reserve_met
    state :canceled
    state :won
    state :reserve_not_met

    event :publish do
      transitions from: :draft, to: :published
    end

    event :reserve_met do
      transitions from: :published, to: :reserve_met
    end

    event :cancel do
      transitions from: :published, to: :canceled
    end

    event :won do
      transitions from: :reserve_met, to: :won
    end

    event :reserve_not_met do
      transitions from: [:draft, :published, :canceled], to: :reserve_not_met
    end

  end
end
