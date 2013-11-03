class AddViralToBeta < ActiveRecord::Migration
  def change
    add_column :beta, :viral, :string
  end
end
