class CreateGpsChecks < ActiveRecord::Migration[6.0]
  def change
    create_table :gps_checks do |t|
      t.string :image
      t.timestamps
    end
  end
end
