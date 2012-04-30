require 'sinatra/base'

module Sinatra
  module WarmGum
    module Base
      def self.registered(app)
        puts app.inspect
      end

    end
  end

  register WarmGum::Base
end
