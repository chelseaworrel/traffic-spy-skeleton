class AddResolutionColumnsToVistors < ActiveRecord::Migration
  def change
    add_column :visitors, :resolution_width, :text
    add_column :visitors, :resolution_height, :text
  end
end


#add column takes 3 paramaters:
#name of the table it is modifying (:tasks)
#name of the column you are adding to that table - name is important has to be singular_id (:user_id)
#type (:integer)
