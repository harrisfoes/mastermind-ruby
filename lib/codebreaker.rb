class Codebreaker

  CODE_ELEMENTS = ['r', 'g', 'b', 'y', 'm', 'c'].freeze
  CODE_LENGTH = 4

  def initialize
    @possible_codes = CODE_ELEMENTS.repeated_permutation(CODE_LENGTH).to_a
  end

  def make_guess
    @possible_codes.first
  end

  def update_possible_codes(last_guess, feedback)
    @possible_codes.select! do |code|
      evaluate_guess(last_guess, code) == feedback
    end
  end

  private

  def evaluate_guess(guess, answer)
    result = []
    guess_used = Array.new(CODE_LENGTH, false)
    answer_used = Array.new(CODE_LENGTH, false)

    # Exact matches (X)
    guess.each_with_index do |ch, idx|
      if ch == answer[idx]
        result << 'X'
        guess_used[idx] = true
        answer_used[idx] = true
      end
    end

    # Partial matches (x)
    guess.each_with_index do |ch, idx|
      next if guess_used[idx]

      answer.each_with_index do |ans, jdx|
        if !answer_used[jdx] && ch == ans
          result << 'x'
          answer_used[jdx] = true
          break
        end
      end
    end

    result.join
  end
end
