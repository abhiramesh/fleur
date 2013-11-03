class AddReferrerToBetas < ActiveRecord::Migration
  def change
    add_column :beta, :referrer, :string
  end
end
