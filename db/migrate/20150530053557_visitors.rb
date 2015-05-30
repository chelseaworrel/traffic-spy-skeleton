class Visitors < ActiveRecord::Migration
  def change
    create_table :visitors do |t|
      t.text :user_agent

      t.timestamps null: false
    end
  end
end
