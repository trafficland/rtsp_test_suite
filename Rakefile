require 'rubygems'
require 'rake'
require 'rake/clean'
require 'rubygems/package_task'
require 'rdoc/task'
require 'rake/testtask'
require 'rspec'
require 'rtsp/client'
require 'configatron'
require 'rspec/core/rake_task'
 
spec = Gem::Specification.new do |s|
  s.name = 'rtsp_test_suite'
  s.version = '0.0.1'
  s.has_rdoc = true
  s.extra_rdoc_files = ['README']
  s.summary = 'RSPEC test suite for testing a remote rtsp server.'
  s.description = s.summary
  s.author = 'Nick McCready'
  s.email = 'nemtcan@gmail.com'
  # s.executables = ['your_executable_here']
  s.files = %w(LICENSE.rdoc README Rakefile) + Dir.glob("{bin,lib,spec}/**/*")
  s.require_path = "lib"
  s.bindir = "bin"
end

Gem::PackageTask.new(spec) do |p|
  p.gem_spec = spec
  p.need_tar = true
  p.need_zip = true
end

Rake::RDocTask.new do |rdoc|
  files =['README', 'LICENSE.rdoc', 'lib/**/*.rb']
  rdoc.rdoc_files.add(files)
  rdoc.main = "README" # page to start on
  rdoc.title = "rtsp_tester Docs"
  rdoc.rdoc_dir = 'doc/rdoc' # rdoc output folder
  rdoc.options << '--line-numbers'
end

test = Rake::TestTask.new do |t|
  t.test_files = FileList['test/**/*.rb']
end

RSpec::Core::RakeTask.new(:spec)

task :default => :spec