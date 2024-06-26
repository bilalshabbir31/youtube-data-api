# frozen_string_literal: true

# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 20_240_601_095_353) do
  # These are extensions that must be enabled in order to support this database
  enable_extension 'plpgsql'

  create_table 'channels', force: :cascade do |t|
    t.string 'name'
    t.string 'yt_channel_id'
    t.datetime 'created_at', null: false
    t.datetime 'updated_at', null: false
    t.string 'description'
    t.string 'custom_url'
    t.datetime 'published_at'
    t.bigint 'view_count'
    t.bigint 'subscriber_count'
    t.boolean 'hidden_subscriber_count'
    t.bigint 'video_count'
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
    t.bigint 'comment_count'
    t.bigint 'favorite_count'
    t.bigint 'like_count'
    t.bigint 'view_count'
    t.index ['channel_id'], name: 'index_videos_on_channel_id'
  end

  add_foreign_key 'videos', 'channels'
end
