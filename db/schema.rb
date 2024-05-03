# frozen_string_literal: true

ActiveRecord::Schema[7.1].define(version: 20_240_204_113_210) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'channels', force: :cascade do |t|
    t.string 'name'
    t.string 'yt_channel_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
  end

  create_table 'videos', force: :cascade do |t|
    t.string 'yt_video_id'
    t.text 'title'
    t.text 'description'
    t.string 'duration'
    t.text 'tags'
    t.datetime 'published_at'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.bigint 'channel_id', null: false
    t.index ['channel_id'], name: 'index_videos_on_channel_id'
  end

  add_foreign_key 'videos', 'channels'
end
