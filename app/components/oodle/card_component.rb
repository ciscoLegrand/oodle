# frozen_string_literal: true

module Oodle
  class CardComponent < ViewComponent::Base
    include Turbo::FramesHelper

    def initialize(title: nil, id: nil, actions: [], &block)
      @title = title
      @id = id
      @actions = actions
    end
  end
end
