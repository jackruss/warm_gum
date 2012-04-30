require 'sinatra/base'

module Sinatra
  module WarmGum
    module IndividualAddressees
      def self.registered(app)
        #put actions here
      end
    end
  end

  register WarmGum::IndividualAddressees
end
