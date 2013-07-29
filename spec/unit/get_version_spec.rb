require 'rtsp_test_suite'

describe "Version should" do
  subject do
    RTSP_TEST_SUITE::VERSION
    end

  describe "version" do
    it "extracts version 0.0.1a" do
      subject.should == "0.0.1a"
    end
  end
end
