class AddCafProtocolNumberToIsee < ActiveRecord::Migration
  def change
    add_column :isees, :caf_protocol_number, :string
  end
end
