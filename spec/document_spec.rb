require 'spec_helper'

def sample_doc
  Document.new(['foo', 'foo', 'bar', 'foo'])
end

describe Document, '#frequency' do
  it 'returns the number of times a term appears' do
    expect(sample_doc.frequency('foo')).to eq 3.0
  end

  it 'return 0 if a term does not appear in the document' do
    expect(sample_doc.frequency('baz')).to eq 0.0
  end
end

describe Document, '#terms' do
  it 'returns all the terms in the document' do
    expect(sample_doc.terms.sort).to eq ['bar', 'foo']
  end
end

describe Document, '#normalize!' do
  it 'inverts the frequency of the terms in place' do
    doc = sample_doc
    corpus = Document.new(['foo', 'foo', 'bar', 'foo', 'bar', 'baz'])

    doc.normalize!(corpus)

    expect(doc.frequency('foo')).to eq 1.0
    expect(doc.frequency('bar')).to eq 0.5
    expect(doc.frequency('baz')).to eq 0.0
  end
end

describe Document, '#similarity' do
  it 'returns the dot product between itself and a query document' do
    doc = sample_doc
    query = Document.new(['foo', 'baz'])

    expect(doc.similarity(query)).to eq 3.0
  end
end
