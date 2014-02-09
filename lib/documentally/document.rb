class Documentally::Document
  attr_accessor :term_hash

  def initialize(terms)
    @term_hash = Hash.new(0.0)

    terms.each do |term|
      @term_hash[term] += 1
    end
  end

  def terms
    term_hash.keys
  end

  def frequency(term)
    term_hash[term]
  end

  def ==(other)
    union_of_terms = (terms + other.terms).uniq
    union_of_terms.all? { |term| frequency(term) == other.frequency(term) }
  end

  def similarity(query)
    terms.map { |term| frequency(term) * query.frequency(term) }.inject(&:+)
  end

  def normalize!(corpus)
    terms.each do |term|
      term_hash[term] /= corpus.frequency(term)
    end
  end
end
