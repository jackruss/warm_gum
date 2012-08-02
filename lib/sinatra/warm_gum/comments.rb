module Sinatra
  module WarmGum
    module Comments
      EXTENSION_METADATA = { 'participation' => { 'comments' => [] } }
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'comments' => message.comments }
      end

      def self.registered(app)

        Message.register_extension_metadata(EXTENSION_METADATA)

        app.post %r{/messages/(#{app.settings.id_format})/comments} do |message_id|
          @comment = params['comment']
          if @message.add_comment(@comment)
            message_json @message
          else
            halt 400, app.settings.errors[285]
          end
        end

        app.get %r{/messages/(#{app.settings.id_format})/comments} do |message_id|
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
