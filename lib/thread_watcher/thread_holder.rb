module ThreadWatcher
  class ThreadHolder
    attr_accessor :thread, :id, :options, :block
    def initialize block, options
      @block = block
      @id = time_to_i
      @options = available_options.merge options
    end

    def run!
      puts "now running"
      Thread.new{ block.call }
    end

    def stop!
      @thread.kill
    end
    
    def restart!
      @thread = Thread.new { block.call }
    end

    def alive?
      @thread.alive?
    end

    def runtime
      time_to_i - @id
    end

    def time_to_i
      Time.now.to_i
    end

    private

    def available_options
      { :name => nil, :keep_alive => false }
    end
  end
end