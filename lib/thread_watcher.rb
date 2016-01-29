require "thread_watcher/version"
require "thread_watcher/process_watch"

module ThreadWatcher
  require 'singleton'
  class Monitor
    include Singleton

    def initialize
      @process_watch = ThreadWatcher::ProcessWatch.new
    end

    def run options = {}, &block
      @process_watch.run options, &block
    end

    def self.run options = {}, &block
      instance.run options, &block
    end

    def kill id
      @process_watch.kill id
    end

    def self.kill id
      instance.kill id
    end

    def kill! id
      @process_watch.kill! id
    end

    def self.kill! id
      instance.kill! id
    end

    def restart id
      @process_watch.restart id
    end

    def self.restart id
      instance.restart id
    end

    def status
      @process_watch.status
    end

    def self.status
      instance.status
    end
  end
end
