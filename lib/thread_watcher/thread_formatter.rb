module ThreadWatcher
  class ThreadFormatter
    def self.headline
      self.output "|ID\t\t|Running?\t|Runtime in Seconds\t|"
    end

    def self.data thread
      self.output "|#{thread.id}\t|#{thread.alive?}\t\t|\t#{thread.runtime}\t\t|"
    end

    def self.output content
      puts content
    end
  end
end