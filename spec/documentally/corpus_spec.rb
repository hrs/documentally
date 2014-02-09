require 'spec_helper'

describe Documentally do
  def setup
    term_lists = [['foo', 'foo', 'bar'],
                  ['bar', 'baz', 'baz'],
                  ['bar', 'baz', 'foo']]

    all_terms_document = Documentally::Document.new(term_lists.inject(&:+))

    docs = term_lists.map { |term_list| Documentally::Document.new(term_list) }
    docs.each do |doc|
      doc.normalize!(all_terms_document)
    end

    @doc_1, @doc_2, @doc_3 = docs
    @corpus = Documentally::Corpus.new(*term_lists)
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
      query = Documentally::Document.new(['baz'])

      expect(@corpus.search(query)).to eq [@doc_2]
    end

    it 'optionally returns several documents with the nearest similarities to a given query' do
      setup

      query = Documentally::Document.new(['baz'])

      expect(@corpus.search(query, take: 2)).to eq [@doc_2, @doc_3]
    end
  end
end
