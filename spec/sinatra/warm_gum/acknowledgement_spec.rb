require './lib/sinatra/warm_gum/acknowledgement.rb'
require 'rspec'
require 'rack/test'
require 'json'

describe Sinatra::WarmGum::Acknowledgement do
  include Rack::Test::Methods

  class Sinatra::WarmGum::Message
    def self.register_extension_metadata(metadata)
    end
  end

  class User
    def id
      1
    end
  end

  class App < Sinatra::Application
    set :environment, :test
    set :id_format, /\d+/
    set :per_page, 10

    before do
      @authenticated_user = User.new
    end

    register Sinatra::WarmGum::Acknowledgement
  end

  def app
    App
  end

  let(:paginator) { double('paginator', :page => double('paginator', :per => 1)) }

  context 'GET /acknowledged' do
    let(:message_json) {
      content_type :json
      { 'messages' => [] }
    }
    before do
      app.any_instance.stub(:message_json).and_return(message_json)
    end
    it "says hello" do
      Sinatra::WarmGum::Message.should_receive(:acknowledged).with(1).and_return(paginator)
      get '/acknowledged'
      last_response.should be_ok
      last_response.body.should == message_json.to_json
    end
  end
end
