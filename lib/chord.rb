class Chord
  ACCIDENTALS = /(?:#|b|♭)?/
  CHORD_TYPES = /(maj|min|m|sus|dim|aug)?/
  CHORD_EXTENSIONS = /(2|4|5|7|9|13)?/
  BASS_NOTE = %r{(?:/([A-Ga-g]#{ACCIDENTALS}))?}
  NOTE_REGEX = /([A-Ga-g]#{ACCIDENTALS})#{CHORD_TYPES}#{CHORD_EXTENSIONS}#{BASS_NOTE}/

  attr_accessor :note, :type, :extension, :bass_note

  def initialize(chord_parts)
    @note = chord_parts[0]
    @type = chord_parts[1]
    @extension = chord_parts[2]
    @bass_note = chord_parts[3]
  end

  def to_s
    chord = [@note, @type, @extension].join
    chord += "/#{@bass_note}" if @bass_note
    chord
  end

  def self.parse(chord_string)
    new(chord_string.match(NOTE_REGEX).to_a[1..])
  end
end