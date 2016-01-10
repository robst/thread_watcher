module ThreadWatcher
  class ProcessWatch
    attr_accessor :threads
    class ThreadHolder
      attr_accessor :thread, :id
      def initialize thread
        @thread = thread
        @id = time_to_i
      end

      def stop!
        @thread.kill
      end

      def alive?
        @thread.alive?
      end

      def to_s
        "|#{id}\t|#{alive?}\t\t|\t#{runtime}\t\t|"
      end

      def runtime
        time_to_i - @id
      end

      def time_to_i
        Time.now.to_i
      end
    end

    def initialize
      @threads = {}
      run { while true; self.clear!; sleep(60); end; }
    end

    def run &block
      thread_holder = ThreadHolder.new(Thread.new { block.call })
      @threads[thread_holder.id] = thread_holder
      thread_holder.id
    end

    def kill id
      @threads[id].stop!
      @threads.delete id
    end

    def clear!
      @threads.each do |key, thread|
        next if thread.alive?
        kill key
      end
    end

    def status
      puts "|ID\t\t|Running?\t|Runtime in Seconds\t|"
      @threads.each do |key, thread|
        puts thread.to_s
      end
      ''
    end
    
  end
end