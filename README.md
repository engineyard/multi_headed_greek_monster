Yet another parallel processing utility.

# To run the test:
```
  ruby -Ilib test/multi_headed_greek_monster_test.rb
```

# Goals:
* forks workers to run work, and then clean up after yourself
* no dependencies
* no threads
* everything in 1 file.

# Primary use case:
A migration that updates many rows.

```ruby
  #make 3 workers, use DRB to communicate over port 28371
  monster = MultiHeadedGreekMonster.new(nil, 3, 28371) do |face, work|
    #do you work on the given record
    face.name = face.name + " improved"
    face.save!
  end
  Face.find_in_batches do |batch_of_things|
    batch_of_things.each do |thing|
      #put 'thing' into the Q of work to be done
      monster.feed(thing)
    end
    #wait for the Q to drain down to no more than 5 waiting items
    monster.wait
  end
  #wait for the Q to drain to empty and all workers to finish. Then shut down the workers and DRB
  monster.finish
```

Copyright (c) 2008-2010 3M. All rights reserved. Released under the MIT license.

Authored by Jacob Burkhart.
