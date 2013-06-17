require 'sdp'
require 'spec_helper'
require 'rtsp/client'
require 'configatron'

describe "Real Server Client use" do
  subject do
    RTSP::Client.new(configatron.rtsp_server.url) do |connection|
      connection.socket = fake_rtsp_server
    end
  end

  describe "#options" do
    it "extracts the server's supported methods" do
      subject.options
      subject.supported_methods.should ==
        [:describe, :setup, :teardown, :play]
    end

    it "returns a Response" do
      response = subject.options
      response.should be_a RTSP::Response
    end
  end
end

