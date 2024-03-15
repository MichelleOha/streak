# db/migrate/20240308005744_make_user_id_nullable_in_payments.rb

class MakeUserIdNullableInPayments < ActiveRecord::Migration[7.1]
  def up
    add_reference :payments, :user, foreign_key: true, null: true, index: true
  end

  def down
    add_reference :payments, :user, foreign_key: true, null: true, index: true
  end
end
