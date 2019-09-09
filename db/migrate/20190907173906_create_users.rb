class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :username
      t.string :email
      t.string :password_digest
      t.string :rsvp, default: "Yes"
      t.integer :guest_limit, default: 2
    end
  end
end
