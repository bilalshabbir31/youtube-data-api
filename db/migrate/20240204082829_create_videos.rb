# frozen_string_literal: true

class CreateVideos < ActiveRecord::Migration[7.1]
  def change
    create_table :videos do |t|
      t.string :yt_video_id
      t.text :title
      t.text :description
      t.string :duration
      t.text :tags
      t.datetime :published_at

      t.timestamps
    end
  end
end
