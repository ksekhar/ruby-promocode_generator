require 'spec_helper'

describe PromocodeGenerator::Generator do

  let(:promo_code_generator_default_options) { PromocodeGenerator::Generator.new }
  let(:promo_code_generator_prefix) { PromocodeGenerator::Generator.new(prefix: 'HSN') }
  let(:promo_code_generator_separator) { PromocodeGenerator::Generator.new(prefix: 'HSN', separator: '-') }
  let(:promo_code_generator_of_length_5) { PromocodeGenerator::Generator.new(length: 5) }

  context 'Generated Code' do
    it 'must contain only uppercase alpha numberic values' do
      expect(promo_code_generator_default_options.generate).to match(/[A-Z0-9]/)
    end

    it 'must not contain only lowercase alphabet values' do
      expect(promo_code_generator_default_options.generate).not_to match(/[a-z]/)
    end

    it 'must have the prefix supplied to its options' do
      expect(promo_code_generator_prefix.generate).to match(/HSN/)
    end

    it 'must have the separator supplied to its options' do
      expect(promo_code_generator_separator.generate).to match(/-/)
    end

    it 'must not have vowels by default' do
      expect(promo_code_generator_default_options.generate).not_to match(/[AEIOU]/)
    end

    it 'must not have 1,0 by default' do
      expect(promo_code_generator_default_options.generate).not_to match(/[10]/)
    end

    it 'must be of length passed in options not counting prefix and separator' do
      expect(promo_code_generator_of_length_5.generate.length).to eq(5)
    end

  end

end