# frozen_string_literal: true

class Channel < ApplicationRecord
  has_many :videos
end
