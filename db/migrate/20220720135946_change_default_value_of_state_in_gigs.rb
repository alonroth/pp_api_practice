class ChangeDefaultValueOfStateInGigs < ActiveRecord::Migration[6.0]
  def up
    change_column_default(:gigs, :state, 'applied')
  end
end
