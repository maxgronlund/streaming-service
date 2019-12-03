class CreateWorks < ActiveRecord::Migration[6.0]
  def change
    create_table :works, id: :uuid do |t|
      t.string :title
      t.string :uuid
      t.string :artwork
      t.json :payload

      t.timestamps
    end
  end
end
