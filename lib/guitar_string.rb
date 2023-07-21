class GuitarString
  attr_reader :fret, :note

  def initialize(fret:, note: nil)
    @fret = fret
    @note = note
  end
end