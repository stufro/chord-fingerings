require "./lib/chord"
require "./lib/guitar_string"
require "./lib/fret_modifier"

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
    "m" => FretModifier.new(note: :third, action: ->(fret) { fret - 1 }),
    "7" => FretModifier.new(note: :root, action: ->(fret) { fret - 2})
  }

  def self.generate(chord_string)
    chord = Chord.parse(chord_string)
    base_fingering = BASE_FINGERINGS[chord.note]
    modifier = MODIFIERS[chord.type.to_s + chord.extension.to_s]

    modified_chord(base_fingering, modifier).map(&:fret).join
  end

  private

  def self.modified_chord(base_fingering, modifier)
    wanted_string = base_fingering.find {|f| f.note == modifier&.note && modifier&.can_invoke?(f.fret) }

    base_fingering.map do |guitar_string|
      next(guitar_string) unless guitar_string == wanted_string

      GuitarString.new(fret: modifier.invoke(guitar_string.fret))
    end
  end
end