class CreateChannels < ActiveRecord::Migration[7.1]
  def change
    create_table :channels do |t|
      t.string :name
      t.string :yt_channel_id

      t.timestamps
    end
  end
end
