class GuitarString
  attr_reader :fret, :note

  def initialize(fret:, note:)
    @fret = fret
    @note = note
  end
end