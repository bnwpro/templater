class AddDefaultToNumberOfFamilies < ActiveRecord::Migration
  def up
    change_column :campaigns, :number_of_families, :integer, default: 0
  end
end
