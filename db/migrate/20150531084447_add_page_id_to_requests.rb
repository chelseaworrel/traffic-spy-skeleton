class AddPageIdToRequests < ActiveRecord::Migration
  def change
    add_reference :requests, :page, index: true
  end
end
