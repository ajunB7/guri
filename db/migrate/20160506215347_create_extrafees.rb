class CreateExtrafees < ActiveRecord::Migration
  def change
    create_table :extrafees do |t|
      t.references :student, foreign_key: true
      t.string :name
      t.decimal :price, precision: 8, scale: 2

      t.timestamps
    end
  end
end
