require 'sinatra/base'

module Sinatra
  module WarmGum
    module Search
      def self.registered(app)
        #put actions here
      end
    end
  end

  register WarmGum::Search
end
