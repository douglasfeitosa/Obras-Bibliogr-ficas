class FormatService
  KINS = %w[FILHO FILHA NETO NETA SOBRINHO SOBRINHA JUNIOR]
  ARTICLES = %w[da de do das dos]

  attr_reader :names, :errors

  def self.call(names)
    new(names).call
  end

  def initialize(names)
    @names = names
    @errors = []
  end

  def call
    @names.map { |name| format_name(name.squish) }
  end

  private

  def format_name(name)
    return upcase_name(name) if is_only?(name)
    return kin_name(name) if is_kin?(name)

    normal_name(name)
  end

  def is_only?(name)
    name.length == 1
  end

  def is_kin?(name)
    name.split(' ').any? { |word| KINS.include?(word.upcase) }
  end

  def upcase_name(name)
    name.upcase
  end

  def kin_name(name)
    words = name.split(' ')

    if words.length == 2
      print_name(*words.reverse)
    else
      surname = words[words.length - 2..-1]
      rest_of_name = words - surname

      print_name(surname.join(' '), rest_of_name.join(' '))
    end
  end

  def normal_name(name)
    words = name.split(' ')

    surname = words[words.length - 1..-1]
    rest_of_name = words - surname

    print_name(surname.join(' '), rest_of_name.join(' '))
  end

  def print_name(upcase_name, rest_of_name)
    if rest_of_name.present?
      "#{upcase_name.upcase}, #{formatted_rest_of_name(rest_of_name)}"
    else
      upcase_name.upcase
    end
  end

  def formatted_rest_of_name(rest_of_name)
    rest_of_name.split(' ').map do |word|
      word_downcase = word.downcase
      ARTICLES.include?(word_downcase) ? word_downcase : word.titleize
    end.join(' ')
  end
end
