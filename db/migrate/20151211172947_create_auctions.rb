class CreateAuctions < ActiveRecord::Migration
  def change
    create_table :auctions do |t|
      t.string :title
      t.text :details
      t.datetime :end_date
      t.money :reserve_price
      t.string :aasm_state

      t.timestamps null: false
    end
  end
end
