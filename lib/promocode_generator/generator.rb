require 'active_support'
require 'active_support/core_ext'

class PromocodeGenerator::Generator

  ALPHABET = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ'
  NUMBERS = '1234567890'
  DEFAULT_LENGTH = 10
  DEFAULT_PREFIX = ''
  DEFAULT_RULES = { exclusion: { excluded_characters: 'AEIOU10' } }
  DEFAULT_SEPARATOR = ''

  attr_accessor :length, :prefix, :rules, :retries, :separator

  def initialize(options = {})
    @length = options.fetch(:length, DEFAULT_LENGTH) || DEFAULT_LENGTH
    @prefix = options.fetch(:prefix, DEFAULT_PREFIX) || DEFAULT_PREFIX
    @symbols_used = (ALPHABET+NUMBERS)
    @rules = options.fetch(:rules, DEFAULT_RULES)
    @retries = 0
    @separator = options.fetch(:separator, DEFAULT_SEPARATOR)
  end

  def generate
    apply_rules
    code = []
    code << @prefix
    part = ''
    (1...@length).each { part << random_symbol }
    begin
      part << checkdigit_alg_1(part)
    rescue
      # Due to the randomness checkdigit_alg_1 method would return nil
      # this raises TypeError when inserting a nil into a string
      # so we retry till we don't get nil anymore,
      # the cost of this retry is negligible as it is observed in the above benchmark results
      @retries += 1
      retry
    end
    code << part
    code.join(@separator)
  end

  private

  def apply_rules
    if @rules[:exclusion].present?
      @symbols_used.delete!(@rules[:exclusion][:excluded_characters])
    end
  end

  def checkdigit_alg_1(orig)
    check = rand(@length)
    orig.split('').each_with_index do |c, _|
      k = @symbols_used.index(c)
      check = check * 19 + k
    end
    @symbols_used[check % 31]
  end

  def random_symbol
    @symbols_used[rand(@symbols_used.length)]
  end
end