# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'thread_watcher/version'

Gem::Specification.new do |spec|
  spec.name          = "thread_watcher"
  spec.version       = ThreadWatcher::VERSION
  spec.authors       = ["Robert Starke"]
  spec.email         = ["robertst81@gmail.com"]


  spec.summary       = %q{Monitor your Threads exactly and kill them from each Point of your Application.}
  spec.description   = %q{You need to monitor your threads and kill one specific thread or restart them after scheduling in another part of your application? Then this Gem could be usefull for you. Use it with any ruby version greater or equal than 1.8.7. See detailed information at the github Page.}
  spec.homepage      = "https://github.com/robst/thread_watcher"
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.8"
  spec.add_development_dependency "rake", "~> 10.0"

  spec.required_ruby_version = '>= 1.8.7'
end
