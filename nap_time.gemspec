Gem::Specification.new do | s |
  s.name = 'nap_time'
  s.version = '0.0.1'
  s.author = 'andrew.fong'
  s.email  = 'fong.andrew.j@gmail.com'
  s.summary = 'RESTful API'
  s.description = 'General use gem to test RESTful API'
  
  s.required_ruby_version = '>= 1.9.3'
  s.add_runtime_dependency 'httparty', '~> 0.13.0'
  s.add_runtime_dependency 'yard', '~> 0.8' 
end