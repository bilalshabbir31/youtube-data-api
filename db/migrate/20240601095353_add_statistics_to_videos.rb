# frozen_string_literal: true

class AddStatisticsToVideos < ActiveRecord::Migration[7.1]
  def change
    add_column :videos, :comment_count, :bigint
    add_column :videos, :favorite_count, :bigint
    add_column :videos, :like_count, :bigint
    add_column :videos, :view_count, :bigint
  end
end
