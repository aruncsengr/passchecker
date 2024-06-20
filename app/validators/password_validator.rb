class PasswordValidator < ActiveModel::EachValidator
  attr_reader :value

  ERROR_MESSAGE = 'must contain at least one lowercase character, one uppercase character, '\
    'one digit and cannot contain three repeating characters.'

  def validate_each(record, attribute, value)
    return if value.blank?

    @value = value
    unless valid?
      record.errors.add attribute, (options[:message] || ERROR_MESSAGE)
    end
  end

  private

  def valid?
    at_least_one_lowercase_char? &&
    atleast_one_uppercase_char? &&
    atleast_one_digit? &&
    not_containing_three_repeating_chars?
  end

  def at_least_one_lowercase_char?
    value.match?(/[a-z]/)
  end

  def atleast_one_uppercase_char?
    value.match?(/[A-Z]/)
  end

  def atleast_one_digit?
    value.match?(/[0-9]/)
  end

  def not_containing_three_repeating_chars?
    !value.match?(/(.)\1{2,}/)
  end
end
