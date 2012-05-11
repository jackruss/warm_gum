require 'sinatra/base'

module Sinatra
  module WarmGum
    module GroupAddressees
      METADATA_TRANSFORM = Proc.new do |message, options|
        { 'group_addressees' => message.group_addressees }
      end

      def self.registered(app)
        groups_metadata_defaults = GROUPS.inject({}) { |result, group| result.merge!(group => []) }
        extension_metadata = { 'addressees' => { 'group' => groups_metadata_defaults } }
        Message.register_extension_metadata(extension_metadata)

        app.put %r{^/messages/(#{ID_FORMAT})/addressees/group/(#{GROUPS.join('|')})/(\d+)$} do |message_id, group, group_addressee_id|
          if can_read_group?(group, group_addressee_id)
            @message = Message.find(message_id)
            @message.add_group_addressee(group, group_addressee_id)
            message_json @message
          else
            halt 403, 'Forbidden'
          end
        end

        app.delete %r{^/messages/(#{ID_FORMAT})/addressees/group/(#{GROUPS.join('|')})/(\d+)$} do |message_id, group, group_addressee_id|
          if can_read_group?(group, group_addressee_id)
            @message = Message.find(message_id)
            @message.remove_group_addressee(group, group_addressee_id)
            message_json @message
          else
            halt 403, 'Forbidden'
          end
        end

      end
    end
  end
end
