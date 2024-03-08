# db/migrate/20240308005744_make_user_id_nullable_in_payments.rb

class MakeUserIdNullableInPayments < ActiveRecord::Migration[7.1]
  def change
    change_column :payments, :user_id, :integer, null: true
  end
end
