require "./lib/chord"
require "./lib/guitar_string"

class ChordFingering
  BASE_FINGERINGS = {
    "A" => [
      GuitarString.new(fret: "x", note: nil),
      GuitarString.new(fret: "0", note: :root),
      GuitarString.new(fret: "2", note: :fifth),
      GuitarString.new(fret: "2", note: :root),
      GuitarString.new(fret: "2", note: :third),
      GuitarString.new(fret: "0", note: :fifth),
    ],
    "D" => [
      GuitarString.new(fret: "x", note: nil),
      GuitarString.new(fret: "x", note: nil),
      GuitarString.new(fret: "0", note: :root),
      GuitarString.new(fret: "2", note: :fifth),
      GuitarString.new(fret: "3", note: :root),
      GuitarString.new(fret: "2", note: :third),
    ]
  }

  MODIFIERS = {
    "m" => { note: :third, modifier: ->(fret) { fret - 1 } }
  }

  def self.generate(chord_string)
    chord = Chord.parse(chord_string)

    base_fingering = BASE_FINGERINGS[chord.note]

    if chord.type
      modifier = MODIFIERS[chord.type]
      guitar_string = base_fingering.find {|f| f.note == modifier[:note] }
      guitar_string.fret = modifier[:modifier].call(guitar_string.fret.to_i)
    end

    base_fingering.map(&:fret).join
  end
end