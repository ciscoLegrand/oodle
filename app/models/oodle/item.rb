module Oodle
  class Item < ApplicationRecord
    validates :name, :description, :score, presence: true
  end
end
