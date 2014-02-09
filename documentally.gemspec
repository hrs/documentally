Gem::Specification.new do |s|
  s.name = 'documentally'
  s.version = '0.0.1'

  s.authors = ['Harry Schwartz', 'Dan Honey']
  s.email = 'hello@harryrschwartz.com'
  s.files = ['README.md'] + Dir.glob('lib/**/*')
  s.homepage = 'http://github.com/hrs/documentally'
  s.license = 'GPL'
  s.require_paths = ['lib']
  s.summary = 'Simple TF-IDF document search library.'
end
