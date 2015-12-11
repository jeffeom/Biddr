class AddAasmStateToBid < ActiveRecord::Migration
  def change
    add_column :bids, :aasm_state, :string
  end
end
