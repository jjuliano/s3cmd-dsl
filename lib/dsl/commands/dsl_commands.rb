module DSLCommands
  def bucket(bucket)
    @bucket = bucket
    self
  end
  alias :remote_bucket :bucket
  alias :object :bucket
  alias :remote_file :bucket

  def files(*files)
    @files = files.join(' ')
    self
  end
  alias :local_files :files
  alias :file :files
end
