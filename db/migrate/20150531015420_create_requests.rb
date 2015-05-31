class CreateRequests < ActiveRecord::Migration
  def change
    create_table :requests do |t|
      t.float :responded_in

      t.timestamps null: false
    end
  end
end
