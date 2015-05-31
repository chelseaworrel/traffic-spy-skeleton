class AddPageIdToRequests < ActiveRecord::Migration
  def change
    add_column :requests, :page_id, :integer
  end
end
