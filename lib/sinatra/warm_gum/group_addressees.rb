require 'sinatra/base'

module Sinatra
  module WarmGum
    module GroupAddresses
      def self.registered(app)
        #put actions here
      end
    end
  end

  register WarmGum::GroupAddresses
end
