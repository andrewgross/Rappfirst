require 'rake/testtask'
require 'bundler/gem_tasks'

# Immediately sync all stdout so that tools like buildbot can
# immediately load in the output.
$stdout.sync = true
$stderr.sync = true

# Change to the directory of this file.
Dir.chdir(File.expand_path("../", __FILE__))

# This installs the tasks that help with gem creation and
# publishing.
Bundler::GemHelper.install_tasks

Rake::TestTask.new do |t|
  t.test_files = FileList['spec/lib/rappfirst/*_spec.rb']
  t.verbose = true
end

task :default => :test