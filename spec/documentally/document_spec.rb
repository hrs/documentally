require 'spec_helper'
require 'documentally'

describe Documentally do
  def sample_doc
    Documentally::Document.new('sample_document', ['foo', 'foo', 'bar', 'foo'])
  end

  describe Documentally::Document, '#frequency' do
    it 'returns the number of times a term appears' do
      expect(sample_doc.frequency('foo')).to eq 3.0
    end

    it 'return 0 if a term does not appear in the document' do
      expect(sample_doc.frequency('baz')).to eq 0.0
    end
  end

  describe Documentally::Document, '#==' do
    it 'returns true if two documents have the same terms and frequencies' do
      doc_1 = sample_doc
      doc_2 = sample_doc

      expect(doc_1).to eq doc_2
    end

    it 'returns false if two documents have different terms or frequencies' do
      doc_1 = sample_doc
      doc_2 = Documentally::Document.new('other', ['lol', 'wut'])

      expect(doc_1).not_to eq doc_2
    end
  end

  describe Documentally::Document, '#terms' do
    it 'returns all the terms in the document' do
      expect(sample_doc.terms.sort).to eq ['bar', 'foo']
    end
  end

  describe Documentally::Document, '#normalize!' do
    it 'inverts the frequency of the terms in place' do
      doc = sample_doc
      corpus = Documentally::Document.new('corpus', ['foo', 'foo', 'bar', 'foo', 'bar', 'baz'])

      doc.normalize!(corpus)

      expect(doc.frequency('foo')).to eq 1.0
      expect(doc.frequency('bar')).to eq 0.5
      expect(doc.frequency('baz')).to eq 0.0
    end
  end

  describe Documentally::Document, '#similarity' do
    it 'returns the dot product between itself and a query document' do
      doc = sample_doc
      query = Documentally::Document.new('query', ['foo', 'baz'])

      expect(doc.similarity(query)).to eq 3.0
    end
  end

  describe Documentally::Document, '#to_s' do
    it 'returns the document name' do
      doc = sample_doc

      expect(doc.to_s).to eq 'sample_document'
    end
  end
end
