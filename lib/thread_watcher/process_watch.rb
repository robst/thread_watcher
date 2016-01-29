require "thread_watcher/thread_formatter"

module ThreadWatcher
  class ProcessWatch
    attr_accessor :threads
    class ThreadHolder
      attr_accessor :thread, :id, :options, :block
      def initialize thread, options
        @thread = thread
        @id = time_to_i
        @options = available_options.merge options
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

    def initialize
      @threads = {}
      @blocks = {}
      run(:name => 'Cleaning Jobs', :keep_alive => true) { while true; self.clear!; sleep(5); end; }
    end

    def run options = {}, &block
      thread_holder = ThreadHolder.new(Thread.new { block.call }, options)
      thread_holder
      @threads[thread_holder.id] = thread_holder
      thread_holder.block = block
      thread_holder.id
    end

    def kill id
      return if @threads[id].nil?
      return if @threads[id].options[:keep_alive]
      @threads[id].stop!
      @threads.delete id
    end

    def kill! id
      return if @threads[id].nil?
      @threads[id].options[:keep_alive] = false
      kill id
      ''
    end

    def restart id
      return if @threads[id].nil?
      @threads[id].restart!
      ''
    end

    def clear!
      @threads.each do |key, thread|
        next if thread.alive?
        kill key
      end
    end

    def status
      ThreadFormatter.headline
      @threads.each do |key, thread|
        ThreadFormatter.data thread
      end
      ''
    end
    
  end
end