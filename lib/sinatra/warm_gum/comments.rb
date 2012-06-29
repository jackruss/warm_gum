require 'sinatra/base'

module Sinatra
  module WarmGum
    module Comments
      EXTENSION_METADATA = { 'participation' => { 'comments' => [] } }
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'comments' => message.comments }
      end

      def self.registered(app)

        Message.register_extension_metadata(EXTENSION_METADATA)

        app.post %r{/messages/(#{ID_FORMAT})/comments} do |message_id|
          @message = Message.find(message_id)
          @comment = params['comment']
          if @message.add_comment(@comment)
            message_json @message
          else
            halt 403, json('error' => 'Error adding comment')
          end
        end

        app.get %r{/messages/(#{ID_FORMAT})/comments} do |message_id|
          @message = Message.find(message_id)
          if @message.comments
            json( { 'comments' => @message.comments } )
          else
            halt 403, json('error' => 'Comment does not exist')
          end

        end
      end
    end
  end
end
