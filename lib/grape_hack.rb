module Grape
  module Formatter
    module Json
      class << self
        def call(object, env)
          return object if ! object || object.is_a?(String)
          return object.to_json if object.respond_to?(:to_json)
          raise Grape::Exceptions::InvalidFormatter.new(object.class, 'json')
        end
      end
    end
  end
end
