class Modifier
  attr_reader :note, :action

  def initialize(note:, action:)
    @note = note
    @action = action
  end

  def can_invoke?(number)
    @action.call(number.to_i) >= 0
  end

  def invoke(number)
    @action.call(number.to_i)
  end
end