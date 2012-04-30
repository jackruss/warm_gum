require 'sinatra/base'

module Sinatra
  module WarmGum
    module Read
      def self.registered(app)
        #put actions here
      end
    end
  end

  register WarmGum::Read
end
