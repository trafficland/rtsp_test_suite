=begin
adapted from
https://github.com/turboladen/rtsp
original copyright notice follows:

Copyright © 2011 sloveless, mkirby, nmccready

Permission is hereby granted, free of charge, to any person obtaining a copy of 
this software and associated documentation files (the “Software”), to deal in 
the Software without restriction, including without limitation the rights to 
use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies 
of the Software, and to permit persons to whom the Software is furnished to do 
so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED “AS IS”, WITHOUT WARRANTY OF ANY KIND, EXPRESS OR 
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, 
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER 
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, 
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE 
SOFTWARE.
=end
require 'sdp'
require 'spec_helper'
require 'rtsp/client'

RSpec.configure do |c|
  # declare an exclusion filter
  c.filter_run_excluding :broken => true
end

describe "TrafficLand RTSP Server use" do
  
  # block to show raw output for debugging
  def setup(url)
    response = subject.setup(@mediaUrl) do |transport|
      #puts "SETUP RAW RESPONSE, Trasport: #{transport}"
      #by using a block we can now check the error location of the where the
      #problem begins
      #puts "Pre-ERROR @ RESPONSE #{transport[35]}"
      #puts "Pre-ERROR @ RESPONSE #{transport[36]}"
      #puts "ERROR @ RESPONSE #{transport[37]}"
    end
    return response
  end  
  
  
  subject do
    #urls provided by rtsp client adroid app
    #alkass TV (updated)
    @baseUrl = "127.0.0.1" if @baseUrl.nil?
    @mediaUrl = "#{@baseUrl}/live-kass/kass" if @mediaUrl.nil?
    #puts "RTSP: URL #{@baseUrl}!!!!!"
    #puts "RTSP: Media URL #{@mediaUrl}!!!!!"
    RTSP::Client.new(@mediaUrl) 
  end

  describe "#options" do
    it "extracts the server's supported methods" do
      subject.options
      subject.supported_methods.should ==
        [:options, :describe, :setup, :play, :teardown]
    end

    it "returns a Response" do
      response = subject.options
      response.should be_a RTSP::Response
    end
  end

  #NOT YET IMPLEMENTED!
  #FORBIDDEN by WOWZA server  
  describe "#describe", :broken => true do
    before do
      begin
        puts "Before describe"
        @response = subject.describe
        puts "Response field = #{@response}"   
      rescue RTSP::Error => error
        error.message.should == "403: Forbidden"
      end
    end
        
    it "extracts the aggregate control track" do
      puts "Agg  #{subject.aggregate_control_track}"
      "rtsp://#{@mediaUrl}/sa.sdp/"
    end
        
    it "extracts the media control tracks" do
      subject.media_control_tracks.should == [@mediaUrl]
    end
        
    it "extracts the SDP object" do
      subject.instance_variable_get(:@session_description).should ==
        @response.body
    end
        
    it "extracts the Content-Base header" do
      subject.instance_variable_get(:@content_base).should ==
        URI.parse("#{@mediaUrl}/sa.sdp/")
    end
        
    it "returns a Response" do
      @response.should be_a RTSP::Response
    end
  end
  
  #NOT YET IMPLEMENTED!
  describe "#announce", :broken => true do
    it "returns a Response" do
      sdp = SDP::Description.new
      subject.setup(@mediaUrl)
      response = subject.announce(@mediaUrl, sdp)
      response.should be_a RTSP::Response
    end
  end
  
  #NOT YET IMPLEMENTED!
  describe "#setup", :broken => true do
    after do
      subject.teardown(@mediaUrl)
    end
    
    it "extracts the session number" do
      #RTSP::Client.log = true
      subject.session.should be_empty
      setup(@mediaUrl)
      subject.session[:session_id].to_i.should >= 0
    end
    
    it "changes the session_state to :ready" do
      setup(@mediaUrl)
      subject.session_state.should == :ready
    end
    
    it "extracts the transport header info" do
      subject.instance_variable_get(:@transport).should be_nil
      setup(@mediaUrl)
      transport = subject.instance_variable_get(:@transport)
      #puts "HASH: transport = #{transport}"
      transport[:streaming_protocol].should == "RTP"
      transport[:profile].should == "AVP"
      transport[:broadcast_type].should == "unicast"
      transport[:source].should == "78.100.44.238"
    end
    
    it "returns a Response" do
      response = setup(@mediaUrl)
      response.should be_a RTSP::Response
    end
  end
  
  #NOT YET IMPLEMENTED!
  describe "#play", :broken => true do
    before do
      subject.setup(@mediaUrl)
    end
    
    after do
      subject.teardown(@mediaUrl)
    end
    
    it "changes the session_state to :playing" do
      subject.play(@mediaUrl)
      subject.session_state.should == :playing
    end
    
    it "returns a Response" do
      response = subject.play(@mediaUrl)
      response.should be_a RTSP::Response
    end
  end
  
  #NOT YET IMPLEMENTED!
  describe "#pause", :broken => true do
    before :each do
      subject.setup(@mediaUrl)
    end
  
    after do
      subject.teardown(@mediaUrl)
    end
  
    it "changes the session_state from :playing to :ready" do
      subject.play(@mediaUrl)
      subject.pause(@mediaUrl)
      subject.session_state.should == :ready
    end
  
    it "changes the session_state from :recording to :ready" do
      subject.record(@mediaUrl)
      subject.pause(@mediaUrl)
      subject.session_state.should == :ready
    end
  
    it "returns a Response" do
      response = subject.pause(@mediaUrl)
      response.should be_a RTSP::Response
    end
  end
  
  #NOT YET IMPLEMENTED!
  describe "#teardown", :broken => true do
    before do
      subject.setup(@mediaUrl)
    end
  
    it "changes the session_state to :init" do
      subject.session_state.should_not == :init
      subject.teardown(@mediaUrl)
      subject.session_state.should == :init
    end
  
    it "changes the session_id back to 0" do
      subject.session.should_not be_empty
      subject.teardown(@mediaUrl)
      subject.session.should be_empty
    end
  
    it "returns a Response" do
      response = subject.teardown(@mediaUrl)
      response.should be_a RTSP::Response
    end
  end

  #NOT IMPLEMENTED!
  describe "#get_parameter", :broken => true do
    it "returns a Response" do
      response = subject.get_parameter(@mediaUrl, "ping!")
      response.should be_a RTSP::Response
    end
  end
  
  #NOT IMPLEMENTED!
  describe "#set_parameter", :broken => true do
    it "returns a Response Error 403 response" do
      begin  
        response = subject.set_parameter(@mediaUrl, "ping!")
      
      rescue RTSP::Error => error
        error.message.should == "403: Forbidden"
      end
    end
  end
  
  #NOT IMPLEMENTED!
  describe "#record", :broken => true do
    before :each do
      subject.setup(@mediaUrl)
    end
    
    after do
      subject.teardown(@mediaUrl)
    end
    
    it "returns a Response" do
      response = subject.record(@mediaUrl)
      response.is_a?(RTSP::Response).should be_true
    end
    
    it "changes the session_state to :recording", :broken => true do
      subject.session_state.should == :ready
      subject.record(@mediaUrl)
      subject.session_state.should == :recording
    end
  end
end