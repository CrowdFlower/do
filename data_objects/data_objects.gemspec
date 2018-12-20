Gem::Specification.new do |s|
  # basic information
  s.name        = "data_objects"
  s.version     = '0.10.0'
  s.platform    = Gem::Platform::RUBY

  # description and details
  s.summary     = 'DataObjects basic API and shared driver specifications'
  s.description = "Provide a standard and simplified API for communicating with RDBMS from Ruby + fix for bigint ids"

  # dependencies
  s.add_dependency "addressable", "~>2.0"
  s.add_dependency "extlib", "~>0.9.12"

  # development dependencies
  s.add_development_dependency 'rspec', '~>1.2.0'

  # components, files and paths
  s.files = FileList["lib/**/*.rb", "spec/**/*.rb", "tasks/**/*.rake",
                      "LICENSE", "Rakefile", "*.{markdown,rdoc,txt,yml}"]

  s.require_path = 'lib'

  # documentation
  s.has_rdoc = false

  # project information
  s.homepage          = 'http://github.com/datamapper/do'
  s.rubyforge_project = 'dorb'

  # author and contributors
  s.author      = 'Dirkjan Bussink'
  s.email       = 'd.bussink@gmail.com'
end
