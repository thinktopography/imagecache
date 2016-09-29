lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)

require 'imagecache/version'

Gem::Specification.new do |gem|
  gem.name          = 'imagecache'
  gem.email          = 'greg@thinktopography.com'
  gem.description   = 'Ruby Image Cropping and Caching Library'
  gem.version       = Imagecache::VERSION
  gem.summary       = 'imagecache'
  gem.authors       = ['Greg Kops']
  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map { |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]
  gem.add_development_dependency 'rake'
  gem.add_development_dependency 'minitest'
  gem.add_runtime_dependency 'activesupport', '>= 4.0'
  gem.add_runtime_dependency 'redis', '>= 3.0'
  gem.add_runtime_dependency 'aws-sdk', '>= 1.60.2'
end
