# frozen_string_literal: true

module ActionView
  module Component
    class ContentStore
      class OutletProxy
        def initialize(content_store)
          @content_store = content_store
        end

        def for(key, &block)
          if key == :default
            raise ArgumentError.new("Content outlet `:default` is reserved")
          end

          @content_store.set(key, &block)
        end
      end
    end
  end
end
