# ThreadWatcher

You need to monitor your threads and kill one specific thread in another part of your application? Then this Gem could be usefull for you. Use it with any ruby version greater or equal than 1.8.7


## Installation

hm, yeah. just add this to your Gemfile:

```ruby
gem 'thread_watcher', '~> 0.2.0'
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
ThreadWatcher starts automaticly a cleaning task to kill dead threads every minute.

Let's say you type something like

```ruby
  ThreadWatcher::Monitor.run { sleep 10000000 }
```

And you want to kill this worker. So just use the process id to kill the thread

```ruby
  ThreadWatcher::Monitor.kill 1452333224
```

Your thread is now killed.


If you need more information about these threads so use

```ruby
  ThreadWatcher::Monitor.status
```

And you get a simple overview like

```
ID  Running?
1452336691  false
1452336714  true
1452336723  false
1452336724  false
1452336726  true
```


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