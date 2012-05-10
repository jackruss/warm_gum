require 'sinatra/base'

module Sinatra
  module WarmGum
    module GroupAddressees

      def self.registered(app)
        groups_metadata_defaults = GROUPS.inject({}) { |result, group| result.merge!(group => []) }
        extension_metadata = { 'addressees' => { 'group' => groups_metadata_defaults } }

        Message.register_extension_metadata(extension_metadata)
        Message.metadata_transform do |options|
          @json_extensions.merge!('group_addressees' => self.metadata['addressees']['group'])
        end

        app.put %r{^/messages/#{ID_FORMAT}/addressees/group/(#{GROUPS.join('|')})/(\d+)$} do |message_id, group, group_addressee_id|
          @message = Message.find(message_id)
          @message.add_group_addressee(group, group_addressee_id)
          json @message.as_json
        end

        app.delete %r{^/messages/#{ID_FORMAT}/addressees/group/(#{GROUPS.join('|')})/(\d+)$} do |message_id, group, group_addressee_id|
          @message = Message.find(message_id)
          @message.remove_group_addressee(group, group_addressee_id)
          json @message.as_json
        end

      end
    end
  end
end
