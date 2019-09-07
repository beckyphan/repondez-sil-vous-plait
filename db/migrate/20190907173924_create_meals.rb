class CreateMeals < ActiveRecord::Migration
  def change
    create_table :meals do |t|
      t.string :menu_item
      t.string :notes
      t.belongs_to :guest
    end
  end
end
