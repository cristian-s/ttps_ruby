class Game
  @@max_tries = 5
  @@id = 0

  attr_accessor(:actual_word, :current_word, :state, :remaining_tries, :has_won, :id)

  def initialize(word, *indexes_to_reveal)
    self.id = @@id
    @@id += 1
    self.actual_word = word
    setup_current_word(indexes_to_reveal)
    self.state = :ready
    self.remaining_tries = @@max_tries
  end

  def setup_current_word(indexes_to_reveal)
    self.current_word = actual_word.split("").inject("") { |acum, each| acum += "_" }
    indexes_to_reveal.each { |i| current_word[i] = actual_word[i] }
  end

  def start
    self.state = :playing
  end

  def try_letter(letter)
    if state == :playing
      old_word = current_word
      self.current_word =
        current_word
          .each_char
          .each_with_index
          .inject("") do |str, (char, index)|
            actual_word[index] == letter ? str += letter : str += char
            str
          end
      self.remaining_tries -= 1 if current_word == old_word
      finish if remaining_tries == 0 || current_word == actual_word

      current_word != old_word
    end
  end

  def finish
    self.state = :finish
    self.has_won = current_word == actual_word
  end

  def current_state
    current_state = {
      "finished" => state == :finish,
      "remaining_tries" => remaining_tries,
      "tries" => @@max_tries - remaining_tries,
    }
    if state == :finish
      current_state["has_won"] = has_won
      current_state["actual_word"] = actual_word
    else
      current_state["current_word"] = current_word
    end
    current_state
  end

  def finished
    state == :finish
  end
end
