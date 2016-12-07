module ThreadWatcher
  class ThreadHolder
    attr_accessor :thread, :id, :options, :block, :start_time
    def initialize block, options
      @block = block
      @options = available_options.merge options
      set_id
    end

    def start!
      initialize_starttime
      @thread = Thread.new{ block.call }
    end

    def stop!
      @thread.kill
    end

    def restart!
      stop!
      start!
    end

    def alive?
      @thread.alive?
    end

    def runtime
      time_to_i - start_time
    end

    def time_to_i
      Time.now.to_i
    end

    private

    def available_options
      { name: :noname, keep_alive: false }
    end

    def initialize_starttime
      @start_time = time_to_i
    end

    def set_id
      @id = options[:id]
    end
  end
end
