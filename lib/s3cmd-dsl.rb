  # = s3cmd-dsl - A gem providing a ruby DSL interface to s3cmd Amazon S3 client.
  #
  # Homepage::  http://github.com/jjuliano/s3cmd-dsl
  # Author::    Joel Bryan Juliano
  # Copyright:: (cc) 2013 Joel Bryan Juliano
  # License::   MIT
  #
  require_relative 'version'

  Dir[File.join(File.dirname(__FILE__), 'dsl/**/*.rb')].sort.reverse.each { |lib| require lib }

