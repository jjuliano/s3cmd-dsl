require_relative 's3cmd'

module S3Cmd
  def s3cmd(name = nil, command = nil, execute = nil, &block)
    s3cmd = S3CmdDSL.new(name)
    s3cmd.send(command) if command
    s3cmd.execute if execute == 'execute'
    if block_given? && command.nil?
      s3cmd.instance_eval(&block)
    end
    s3cmd.send_block_command
  end
end
