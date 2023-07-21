class GuitarString
  attr_accessor :fret, :note

  def initialize(fret:, note:)
    @fret = fret
    @note = note
  end
end