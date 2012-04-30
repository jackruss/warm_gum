require 'sinatra/base'

module Sinatra
  module WarmGum
    module Labels
      def self.registered(app)
        #put actions here
      end
    end
  end

  register WarmGum::Labels
end
