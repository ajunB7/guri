class CreateStudents < ActiveRecord::Migration
  def change
    create_table :students do |t|
      t.string :name
      t.decimal :fee, precision: 8, scale: 2

      t.timestamps null: false
    end

    create_table :hours do |t|
      t.integer :count
      t.references :student, index: true

      t.timestamps
    end
  end
end
