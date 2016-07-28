# ThreadWatcher

You need to monitor some big background tasks and kill one specific thread or restart them after scheduling in another part of your application. This Gem put each task in a separate thread, which you can start, stop or restart.

## Important
If you really need a Version which is working with ruby 1.8.7 switch to [ThreadWatcher Version 0.9.0](https://github.com/robst/thread_watcher/tree/v0.9.0)
Ruby 1.8.7 support removed in Version 1.0.0

## Installation

hm, yeah. just add this to your Gemfile:

```ruby
gem 'thread_watcher', '~> 1.0.0'
```

And then execute:
```
  $ bundle
```
Or install it yourself as:
```
  $ gem install thread_watcher
```

Huh, ready to use!

## Usage

Ok, let's say you want to run a big process separatly in a thread.
Something big like sleep(10) ;).

```ruby
  ThreadWatcher::Monitor.run { sleep 10 }
```

Run needs a block to work and return the internal process id.
This could be something like `1452333019`

If your thread is ok, so let them work.
ThreadWatcher starts automaticly a cleaning task to kill all dead threads every minute. You can skip this feature with the option key `keep alive`

Let's say you type something like

```ruby
  ThreadWatcher::Monitor.run { sleep 10000000 }
```

And you want to kill this worker. So just use the process id to kill the thread

```ruby
  ThreadWatcher::Monitor.kill! 1452333224
```

Your thread is now killed.


If you need more information about these threads so use

```ruby
  ThreadWatcher::Monitor.status
```

And you get a simple overview like

```
|ID         |Running? |Runtime in Seconds |Name
|1452537945 |true     | 177               |Cleaning Jobs
|1452538091 |false    | 31                |sleeper9
|1452538106 |true     | 16                |noname
|1452538116 |true     | 6                 |sleeper50
|1452538121 |true     | 1                 |sleeper30


```

### Options

There are some options to specify the behaviour of your processes.

You can also specify your threads with a name if you need it.

```ruby
  ThreadWatcher::Monitor.run(name: 'My Job') { sleep 10 }
```

Sometimes you may want to hold a process instead of automaticly killing them after a minute. For statistics or to restart them. So you can use the `keep_alive` option

```ruby
  ThreadWatcher::Monitor.run(name:'My Job', keep_alive: true) { sleep 10 }
```

Now, the process won't be killed automaticly when he's done. So you can restart them with

```ruby
  ThreadWatcher::Monitor.restart 1452333224
```

You can also kill your process with a keep_alive option by using the `kill!` command.



## The MIT License (MIT)

Copyright (c) 2015  [Robert Starke](robertst81+github@gmail.com)

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.

## Questions?

If you have further questions, code smells, hints or a beer, just contact me :)

## Contributing

1. Fork it ( https://github.com/robst/thread_watcher/fork )
2. Create your feature branch (`git checkout -b my-new-feature`)
3. Commit your changes (`git commit -am 'Add some feature'`)
4. Push to the branch (`git push origin my-new-feature`)
5. Create a new Pull Request
