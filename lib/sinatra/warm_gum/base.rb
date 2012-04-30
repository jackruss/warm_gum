require 'sinatra/base'
require 'sinatra/json'

module Sinatra
  module WarmGum
    module Base
      def self.registered(app)
        app.get '/:id' do
          json :id => 1
        end
      end
    end
  end

  register WarmGum::Base
end
