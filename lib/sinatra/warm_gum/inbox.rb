require 'sinatra/base'

module Sinatra
  module WarmGum
    module Inbox
      def self.registered(app)
        #put actions here
      end
    end
  end

  register WarmGum::Inbox
end
