require File.join(File.dirname(__FILE__), 'lib/version.rb')

Gem::Specification.new do |spec|
  spec.name = %q{s3cmd-dsl}
  spec.version = S3Cmd::VERSION::STRING
  spec.date = %q{2013-04-10}
  spec.authors = ["Joel Bryan Juliano"]
  spec.email = %q{joelbryan.juliano@gmail.com}
  spec.summary = %q{A gem providing a ruby DSL interface to s3cmd Amazon S3 client.}
  spec.homepage = %q{http://github.com/jjuliano/s3cmd-dsl}
  spec.description = %q{A gem providing a ruby DSL interface to s3cmd Amazon S3 client.}
  spec.license = 'MIT'
  spec.files = Dir['lib/**/*.rb']
  spec.test_files = Dir['test/**/*.rb']
end

