class Documentally::Corpus
  attr_reader :documents

  def initialize(term_lists)
    all_terms = term_lists.map(&:last).inject(&:+)
    master_document = Documentally::Document.new('master', all_terms)

    @documents = term_lists.map { |name, term_list| Documentally::Document.new(name, term_list) }
    documents.each do |document|
      document.normalize!(master_document)
    end
  end

  def search(query, take: 1)
    order_documents_by(query).take(take)
  end

  private

  def order_documents_by(query)
    documents.sort_by { |document| document.similarity(query) }.reverse
  end
end
