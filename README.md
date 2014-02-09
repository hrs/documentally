# Documentally

Documentally uses [TF-IDF](http://en.wikipedia.org/wiki/tf-idf) to allow you to easily search and compare text documents.

It's still under development, so the documentation is basically just the tests right now, but an example use would be:

```ruby
term_lists = [['doc_1', ['foo', 'foo', 'bar']],
              ['doc_2', ['bar', 'baz', 'baz']],
              ['doc_3', ['bar', 'baz', 'foo']]]

corpus = Documentally::Corpus.new(term_lists)

query = Documentally::Document.new('query', ['baz'])

corpus.search(query) # => ['doc_2']
```

## Installation

```sh
gem install documentally
```
