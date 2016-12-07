module ThreadWatcher
  class ProcessWatch
    attr_accessor :threads

    def initialize
      @threads = {}
      @current_id = 1
      start_cleaning_job
    end

    def run options = {}, &block
      options = options.merge(id: next_id)
      thread_holder = ThreadHolder.new(block, options)
      thread_holder.start!
      @threads[thread_holder.id] = thread_holder
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

    private

    def next_id
      @current_id += 1
      @current_id
    end

    def start_cleaning_job
      run(name: 'Cleaning Jobs', keep_alive: true) { while true; self.clear!; sleep(60); end; }
    end

  end
end
