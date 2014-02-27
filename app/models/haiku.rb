class Haiku < Sequel::Model
  plugin :timestamps
  many_to_one :user

  def format_lines!
    [ :first, :second, :third ].each do |line|
      self[line] = self[line].strip.gsub(/\s+/, ' ')
    end
  end

  def validate
    super
    format_lines!
    errors.add(:user, 'user must be present') if user.nil?
    { first: 5, second: 7, third: 5 }.each do |line, syllables|
      validate_line(line, syllables)
    end
  end

  def validate_line(line, syllables)
    words = self[line].split.map(& Word.method(:new))
    unless syllables == words.map(&:syllables).reduce(:+)
      errors.add(line, "#{line} line must be exactly #{syllables}")
    end
  rescue ArgumentError => ex
    errors.add(line, "#{ex.message} not supported")
  end
end
