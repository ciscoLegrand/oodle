# frozen_string_literal: true

module Oodle
  class CardComponent < ViewComponent::Base
    include Turbo::FramesHelper

    def initialize(title: nil, id: nil, &block)
      @title = title
      @id = id
    end
  end
end
