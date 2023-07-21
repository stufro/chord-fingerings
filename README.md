An attempt to dynamically generate chord fingerings to be passed to a library which generates SVGs.

# Try it out
```
irb
```

```ruby
irb(main):001:0> require './lib/chord_fingering'
irb(main):002:0> ChordFingering.generate("Am")
=> "x02210"
```