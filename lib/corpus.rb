class Corpus
  attr_reader :documents

  def initialize(*term_lists)
    master_document = Document.new(term_lists.inject(&:+))

    @documents = term_lists.map { |term_list| Document.new(term_list) }
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
