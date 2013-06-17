=begin
adapted from
https://github.com/turboladen/rtsp
original copyright notice follows:

Copyright © 2011 sloveless, mkirby

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
require 'configatron'

describe "Real Server (Wowza) Client use" do
  # puts "Wowza URL: " + configatron.rtsp_server_wowza.url
  subject do
    RTSP::Client.new(configatron.rtsp_server_wowza.url) 
  end

  describe "#options" do
    it "extracts the server's supported methods" do
      subject.options
      subject.supported_methods.should ==
        [:describe, :setup, :teardown, :play, :pause, 
        :options,:announce,:record,:get_parameter]
    end

    it "returns a Response" do
      response = subject.options
      response.should be_a RTSP::Response
    end
  end
end

