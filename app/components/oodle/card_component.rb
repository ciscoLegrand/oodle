# frozen_string_literal: true

module Oodle
  class CardComponent < ViewComponent::Base
    def initialize(title: nil, &block)
      @title = title
    end
  end
end
