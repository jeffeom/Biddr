class RemoveColumnEndDateFromAuctions < ActiveRecord::Migration
  def change
    remove_column :auctions, :end_date
  end
end
