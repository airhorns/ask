class AddCustomerIdToSurveys < ActiveRecord::Migration
  def change
    add_column :surveys, :customer_id, :integer
  end
end
