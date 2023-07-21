require "./lib/chord"
require "./lib/guitar_string"
require "./lib/modifier"

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
    "m" => Modifier.new(note: :third, action: ->(fret) { fret - 1 }),
    "7" => Modifier.new(note: :root, action: ->(fret) { fret - 2})
  }

  def self.generate(chord_string)
    chord = Chord.parse(chord_string)

    base_fingering = BASE_FINGERINGS[chord.note].dup
    result = base_fingering

    if chord.type || chord.extension
      modifier = MODIFIERS[chord.type.to_s + chord.extension.to_s]

      guitar_string = base_fingering.find {|f| f.note == modifier.note && modifier.can_invoke?(f.fret) }
      index_to_replace = base_fingering.index(guitar_string)
      result[index_to_replace] = GuitarString.new(fret: modifier.invoke(guitar_string.fret), note: nil)
    end

    result.map(&:fret).join
  end

  private

  def self.can_decrement?(fret, proc)
    proc.call(fret.to_i) >= 0
  end
end