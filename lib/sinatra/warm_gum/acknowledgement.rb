require 'sinatra/base'

module Sinatra
  module WarmGum
    module Acknowledgement
      def self.registered(app)
        puts app.inspect
      end
    end
  end

  register WarmGum
end
