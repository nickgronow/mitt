class CreateDonations < ActiveRecord::Migration
  def change
    create_table :donations do |t|
      t.string :name
      t.string :email
      t.string :phone
      t.string :type
      t.string :title
      t.float :amount

      t.timestamps
    end
  end
end
