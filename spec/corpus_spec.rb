require 'spec_helper'

def setup
  term_lists = [['foo', 'foo', 'bar'],
                ['bar', 'baz', 'baz'],
                ['bar', 'baz', 'foo']]

  all_terms_document = Document.new(term_lists.inject(&:+))

  docs = term_lists.map { |term_list| Document.new(term_list) }
  docs.each do |doc|
    doc.normalize!(all_terms_document)
  end

  @doc_1, @doc_2, @doc_3 = docs
  @corpus = Corpus.new(*term_lists)
end

describe Corpus, '#documents' do
  it 'creates and normalizes a collection of documents' do
    setup

    [@doc_1, @doc_2, @doc_3].each do |doc|
      expect(@corpus.documents).to include
    end
  end
end

describe Corpus, '#search' do
  it 'returns the document with the nearest similarity to a given query' do
    setup
    query = Document.new(['baz'])

    expect(@corpus.search(query)).to eq [@doc_2]
  end

  it 'optionally returns several documents with the nearest similarities to a given query' do
    setup

    query = Document.new(['baz'])

    expect(@corpus.search(query, take: 2)).to eq [@doc_2, @doc_3]
  end
end
