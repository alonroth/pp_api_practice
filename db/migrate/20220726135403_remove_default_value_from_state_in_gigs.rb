class RemoveDefaultValueFromStateInGigs < ActiveRecord::Migration[6.0]
  def change
    change_column_default(:gigs, :state, nil)
  end
end
