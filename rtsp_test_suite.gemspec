# -*- encoding: utf-8 -*-
lib = File.expand_path('lib/', File.dirname(__FILE__))
$:.unshift lib unless $:.include?(lib)

Gem::Specification.new do |s|
  s.name = "rtsp_test_suite"
  s.version = File.read('VERSION') rescue '0.0.0'

  s.homepage = %q{https://github.com/turboladen/rtsp}
  s.authors = ["Steve Loveless", "Mike Kirby", "Sujin Philip, Nick McCready"]
  s.summary = %q{Library to allow RTSP streaming from RTSP-enabled devices.}
  s.description = %q{This library intends to follow the RTSP RFC document (2326)
to test rtsp/client against other rtsp servers.
}
  s.email = %w{nemtcan@gmail.com}
  s.licenses = %w{MIT}

  #s.executables = %w{rtsp_client}
  s.files = Dir.glob("{lib,bin,spec,tasks}/**/*") + Dir.glob("*.rdoc") +
    %w(.gemtest rtsp_test_suite.gemspec Gemfile Rakefile)
  s.extra_rdoc_files = %w{ChangeLog.rdoc LICENSE.rdoc README}
  s.require_paths = %w{lib}
  s.rubygems_version = "1.7.2"
  s.test_files = Dir.glob("{spec,features}/**/*")

  s.add_runtime_dependency "parslet", ">= 1.1.0"
  s.add_runtime_dependency "rtp", ">= 0.1.3"
  s.add_runtime_dependency "rtsp", ">= 0.4.4a"
  s.add_runtime_dependency "sdp", "~> 0.2.6"
  s.add_runtime_dependency 'version',  '~> 1'

  s.add_development_dependency "bundler"
  s.add_development_dependency "cucumber", ">= 1.1.0"
  s.add_development_dependency "rake", ">= 0.8.7"
  s.add_development_dependency "rspec", ">= 2.5.0"
  s.add_development_dependency "simplecov", ">= 0.4.0"
  s.add_development_dependency "yard", ">= 0.6.0"
  s.add_development_dependency 'version',  '~> 1'
  s.add_development_dependency "rtsp", ">= 0.4.4a"
end
