class RenameTypeInDonations < ActiveRecord::Migration
  def change
	  rename_column :donations, :type, :support_type
  end
end
