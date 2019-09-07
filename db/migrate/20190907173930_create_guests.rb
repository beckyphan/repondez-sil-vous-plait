class CreateGuests < ActiveRecord::Migration
  def change
    create_table :guests do |t|
      t.string :first_name
      t.string :last_name
      t.belongs_to :user
    end
  end
end
