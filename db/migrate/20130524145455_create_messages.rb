class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :content
      t.boolean :read
      t.string :sender_name
      t.string :receiver_name

      t.timestamps
    end
  end
end
