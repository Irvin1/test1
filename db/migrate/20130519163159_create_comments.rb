class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.string :content
      t.string :username
      t.integer :articleid

      t.timestamps
    end
  end
end
