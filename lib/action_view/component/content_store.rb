# frozen_string_literal: true

module ActionView
  module Component
    class ContentStore
      autoload :OutletProxy, "action_view/component/content_store/outlet_proxy"

      def initialize(view_context)
        @view_context = view_context
        @store = {}
      end

      def set(key, &block)
        @store[key] = @view_context.capture(OutletProxy.new(self), &block)
      end

      def get(key, **options, &block)
        if options[:required] && !@store[key]
          fail ArgumentError.new("Content outlet `:#{key}` must be defined")
        end

        if block_given?
          @store[key] or @view_context.capture(&block)
        else
          @store[key]
        end
      end
    end
  end
end
