require_relative 'commands/base_commands'
require_relative 'commands/cloudfront_commands'
require_relative 'dsl'

class S3CmdDSL < BaseCommands::BaseDSLCommands
  include BaseCommands
  include CloudFrontCommands

  def initialize(name)
    @name = name
    @path = `which s3cmd`.strip
    @commands = {}
  end

  def method_missing(method, *args)
    meth = method.to_s.gsub("_", "-").gsub(/^/, "--")
    @commands[meth] = args.join(', ')
    self
  end
end
