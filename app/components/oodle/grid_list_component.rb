# frozen_string_literal: true

module Oodle
  class GridListComponent < ViewComponent::Base
    def initialize(resource:, columns:, actions: [])
      @resource = resource
      @columns = columns
      @actions = actions
    end

    def render?
      @resource.present?
    end

    def display_value(item, column)
      method = column[:method]
      if method.is_a?(Proc)
        method.call(item)
      else
        item.send(method) if item.respond_to?(method)
      end
    end
  end
end
