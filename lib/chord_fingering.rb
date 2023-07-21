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
    "m" => { note: :third, modifier: ->(fret) { fret - 1 } },
    "7" => { note: :root, modifier: ->(fret) { fret - 2} }
  }

  def self.generate(chord_string)
    chord = Chord.parse(chord_string)

    base_fingering = BASE_FINGERINGS[chord.note].dup
    result = base_fingering

    if chord.type || chord.extension
      modifier = MODIFIERS[chord.type.to_s + chord.extension.to_s]

      guitar_string = base_fingering.find {|f| f.note == modifier[:note] && can_decrement?(f.fret, modifier[:modifier]) }
      index_to_replace = base_fingering.index(guitar_string)
      result[index_to_replace] = GuitarString.new(fret: modifier[:modifier].call(guitar_string.fret.to_i), note: nil)
    end

    result.map(&:fret).join
  end

  private

  def self.can_decrement?(fret, proc)
    proc.call(fret.to_i) >= 0
  end
end