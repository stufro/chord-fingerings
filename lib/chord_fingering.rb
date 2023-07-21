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
    "B" => [
      GuitarString.new(fret: "x", note: nil),
      GuitarString.new(fret: "2", note: :root),
      GuitarString.new(fret: "4", note: :fifth),
      GuitarString.new(fret: "4", note: :root),
      GuitarString.new(fret: "4", note: :third),
      GuitarString.new(fret: "2", note: :fifth),
    ],
    "C" => [
      GuitarString.new(fret: "x", note: nil),
      GuitarString.new(fret: "3", note: :root),
      GuitarString.new(fret: "2", note: :third),
      GuitarString.new(fret: "0", note: :fifth),
      GuitarString.new(fret: "1", note: :root),
      GuitarString.new(fret: "0", note: :third),
    ],
    "D" => [
      GuitarString.new(fret: "x", note: nil),
      GuitarString.new(fret: "x", note: nil),
      GuitarString.new(fret: "0", note: :root),
      GuitarString.new(fret: "2", note: :fifth),
      GuitarString.new(fret: "3", note: :root),
      GuitarString.new(fret: "2", note: :third),
    ],
    "E" => [
      GuitarString.new(fret: "0", note: :root),
      GuitarString.new(fret: "2", note: :fifth),
      GuitarString.new(fret: "2", note: :root),
      GuitarString.new(fret: "1", note: :third),
      GuitarString.new(fret: "0", note: :fifth),
      GuitarString.new(fret: "0", note: :root),
    ],
    "F" => [
      GuitarString.new(fret: "1", note: :root),
      GuitarString.new(fret: "3", note: :fifth),
      GuitarString.new(fret: "3", note: :root),
      GuitarString.new(fret: "2", note: :third),
      GuitarString.new(fret: "1", note: :fifth),
      GuitarString.new(fret: "1", note: :root),
    ],
    "G" => [
      GuitarString.new(fret: "3", note: :root),
      GuitarString.new(fret: "2", note: :third),
      GuitarString.new(fret: "0", note: :fifth),
      GuitarString.new(fret: "0", note: :root),
      GuitarString.new(fret: "0", note: :third),
      GuitarString.new(fret: "2", note: :root),
    ],
  }

  MODIFIERS = {
    "m" => [FretModifier.new(note: :third, action: ->(fret) { fret - 1 })],
    "7" => [FretModifier.new(note: :root, action: ->(fret) { fret - 2 })],
    "sus4" => [FretModifier.new(note: :third, action: ->(fret) { fret + 1 })],
    "sus2" => [FretModifier.new(note: :third, action: ->(fret) { fret - 2 })],
    "aug" => [FretModifier.new(note: :fifth, action: ->(fret) { fret + 1 })],
    "dim" => [FretModifier.new(note: :fifth, action: ->(fret) { fret - 1 })],
    "m7" => [
      FretModifier.new(note: :third, action: ->(fret) { fret - 1 }),
      FretModifier.new(note: :root, action: ->(fret) { fret - 2 })
    ],
  }

  def self.generate(chord_string)
    chord = Chord.parse(chord_string)
    base_fingering = BASE_FINGERINGS[chord.note]
    modifiers = MODIFIERS[chord.type.to_s + chord.extension.to_s].dup

    fingering = modifiers.nil? ? base_fingering : modify_chord(base_fingering, modifiers)
    fingering.map(&:fret).join
  end

  private

  def self.modify_chord(base_fingering, modifiers)
    modifier = modifiers.pop
    wanted_string = base_fingering.find {|f| f.note == modifier&.note && modifier&.can_invoke?(f.fret) }

    result = base_fingering.map do |guitar_string|
      next(guitar_string) unless guitar_string == wanted_string

      GuitarString.new(fret: modifier.invoke(guitar_string.fret))
    end

    modifiers.empty? ? result : modify_chord(result, modifiers)
  end
end