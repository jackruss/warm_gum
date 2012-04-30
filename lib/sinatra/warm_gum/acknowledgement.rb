require 'sinatra/base'

module Sinatra
  module WarmGum
    module Acknowledgement
      def self.registered(app)
        #put actions here
      end
    end
  end

  register WarmGum
end
