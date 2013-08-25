class CreateMessages < ActiveRecord::Migration
  def change
    create_table :messages do |t|
      t.string :message_text
      t.string :short_url
      t.timestamps
    end
  end
end
