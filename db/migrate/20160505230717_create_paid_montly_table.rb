class CreatePaidMontlyTable < ActiveRecord::Migration
  def change
    create_table :paidfees do |t|
      t.boolean :paid
      t.references :student, index: true

      t.timestamps
    end
  end
end
