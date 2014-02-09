require 'spec_helper'

describe Documentally do
  def setup
    term_lists = [['doc_1', ['foo', 'foo', 'bar']],
                  ['doc_2', ['bar', 'baz', 'baz']],
                  ['doc_3', ['bar', 'baz', 'foo']]]

    all_terms = term_lists.map(&:last).inject(&:+)
    all_terms_document = Documentally::Document.new('all_terms', all_terms)

    docs = term_lists.map { |name, term_list| Documentally::Document.new(name, term_list) }
    docs.each do |doc|
      doc.normalize!(all_terms_document)
    end

    @doc_1, @doc_2, @doc_3 = docs
    @corpus = Documentally::Corpus.new(term_lists)
  end

  describe Documentally::Corpus, '#documents' do
    it 'creates and normalizes a collection of documents' do
      setup

      [@doc_1, @doc_2, @doc_3].each do |doc|
        expect(@corpus.documents).to include
      end
    end
  end

  describe Documentally::Corpus, '#search' do
    it 'returns the document with the nearest similarity to a given query' do
      setup

      query = Documentally::Document.new('query', ['baz'])

      expect(@corpus.search(query)).to eq [@doc_2]
    end

    it 'optionally returns several documents with the nearest similarities to a given query' do
      setup

      query = Documentally::Document.new('query', ['baz'])

      expect(@corpus.search(query, take: 2)).to eq [@doc_2, @doc_3]
    end
  end
end
