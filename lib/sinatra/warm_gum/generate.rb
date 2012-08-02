require 'sinatra/base'

module Sinatra
  module WarmGum
    module Generate

      def self.registered(app)

        app.post '/generate' do
          # Submit stuffs to generate method
        end

      end
    end
  end
end
