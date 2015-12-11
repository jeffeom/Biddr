class CreateBids < ActiveRecord::Migration
  def change
    create_table :bids do |t|
      t.money :bid_price
      t.references :user, index: true, foreign_key: true

      t.timestamps null: false
    end
  end
end