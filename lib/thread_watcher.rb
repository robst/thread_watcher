require "thread_watcher/version"

module ThreadWatcher
  require 'singleton'
  class Monitor
    include Singleton

    def initialize
      @process_watch = ThreadWatcher::ProcessWatch.new
    end

    def run &block
      @process_watch.run &block
    end

    def self.run
      instance.run
    end

    def kill id
      @process_watch.kill id
    end

    def self.kill id
      instance.kill id
    end

  end
end
