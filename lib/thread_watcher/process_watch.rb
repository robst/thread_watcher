module ThreadWatcher
  class ProcessWatch
    attr_accessor :threads
    class ThreadHoler
      attr_accessor :thread, :id
      def initialize thread
        @thread = thread
        @id = Time.now.to_i
      end

      def stop!
        @thread.kill
      end

      def alive?
        @thread.alive?
      end
    end

    def initialize
      @threads = {}
      run { while true; self.clear!; sleep(60); end; }
    end

    def run &block
      thread_holder = ThreadHoler.new(Thread.new { block.call })
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
  end
end