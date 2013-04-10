require_relative 'dsl_commands'
require_relative 'string'

module BaseCommands
  include DSLCommands

  class BaseDSLCommands
    def path(path)
      @commands[:path] = path
      self
    end
    alias :path_to_s3cmd :path

    def send_block_command
      @send_block_command = if @commands.include? :path
        @commands[:path]
        @commands.delete(:path)
      else
        @path.empty? ? 's3cmd' : @path
      end

      @commands.each do |key, value|
         @send_block_command += " #{key} '#{value}'"
      end

      @send_block_command.gsub!(/\'/, '').strip!
      `#{@send_block_command}` if @execute

      if @save
        File.open(@save, 'w') do |file|
          file.write(
          <<-EOF.unindent_heredoc
          #!/usr/bin/env bash
          ##{@name}
          ##{Time.now}
          #{@send_block_command}
          EOF
          )
        end
      end

      @send_block_command
    end

    def save_script(filename)
      @save = filename
      self
    end

    def execute
      @execute = true
      self
    end
  end

  # Make bucket
  def mb(bucket = nil) # s3://BUCKET
    @commands[:mb] = bucket || @bucket
    self
  end
  alias :create_new_bucket :mb
  alias :make_bucket :mb
  alias :mkdir :mb
  alias :create_bucket :mb

  # Remove bucket
  def rb(bucket = nil) # s3://BUCKET
    @commands[:rb] = bucket || @bucket
    self
  end
  alias :remove_bucket :rb
  alias :rmdir :rb
  alias :delete_bucket :rb

  # List objects or buckets
  def ls(bucket = nil) # s3://BUCKET[/PREFIX]]
    @commands[:ls] = bucket || @bucket
    self
  end
  alias :list_bucket :ls
  alias :list :ls

  # List all object in all buckets
  def la
    @commands[:la] = ''
    self
  end
  alias :list_all :la
  alias :list_all_objects :la

  # Put file into bucket (i.e. upload to S3)
  def put(files = nil, bucket = nil) # FILE [FILE...] s3://BUCKET[/PREFIX]
    put_files = @files || files
    put_bucket = @bucket || bucket

    @commands[:put] = "#{put_files} #{put_bucket}"
    self
  end
  alias :upload :put

  # Get file from bucket (i.e. download from S3)
  def get(object = nil, files = nil) # s3://BUCKET/OBJECT LOCAL_FILE
    get_files = @files || files
    get_object = @bucket || object

    @commands[:get] = "#{get_object} #{get_files}"
    self
  end
  alias :download :get

  # Delete file from bucket
  def del(object = nil) # s3://BUCKET/OBJECT
    @commands[:del] = @bucket || object
    self
  end
  alias :delete :del
  alias :rm :del
  alias :delete_object :del
  alias :delete_file :del
  alias :remove :del

  # Backup a directory tree to S3
  # Restore a tree from S3 to local directory
  def sync(src_object, dest_object) # LOCAL_DIR s3://BUCKET[/PREFIX] or s3://BUCKET[/PREFIX] LOCAL_DIR
    @commands[:sync] = "#{src_object} #{dest_object}"
    self
  end
  alias :sync_directory :sync
  alias :sync_dir :sync
  alias :synchronize :sync

  # Make a copy of a file (cp) or move a file (mv).  Destination can be in the same bucket with  a  dif‐
  # ferent name or in another bucket with the same or different name.  Adding --acl-public will make the
  # destination object publicly accessible (see below).
  def cp(src_bucket, dest_bucket) # s3://BUCKET1/OBJECT1 s3://BUCKET2[/OBJECT2]
    @commands[:cp] = "#{src_bucket} #{dest_bucket}"
    self
  end
  alias :copy :cp

  # Make a copy of a file (cp) or move a file (mv).  Destination can be in the same bucket with  a  dif‐
  # ferent name or in another bucket with the same or different name.  Adding --acl-public will make the
  # destination object publicly accessible (see below).
  def mv(src_bucket, dest_bucket) # s3://BUCKET1/OBJECT1 s3://BUCKET2[/OBJECT2]
    @commands[:mv] = "#{src_bucket} #{dest_bucket}"
    self
  end
  alias :move :mv

  # Modify Access control list for Bucket or Files. Use with --acl-public or --acl-private
  def setacl(bucket = nil) # s3://BUCKET[/OBJECT]
    @commands[:setacl] = @bucket || bucket
    self
  end
  alias :set_access_control_list :setacl

  # Get various information about a Bucket or Object
  def info(bucket = nil) # s3://BUCKET[/OBJECT]
    @commands[:info] = @bucket || bucket
    self
  end

  # Disk usage - amount of data stored in S3
  def du(bucket = nil) # [s3://BUCKET[/PREFIX]]
    @commands[:du] = @bucket || bucket
    self
  end
  alias :disk_usage :du

  # Enable/disable bucket access logging
  def accesslog(bucket = nil)
    @commands[:accesslog] = @bucket || bucket
    self
  end
  alias :logging :accesslog

  # Sign arbitrary string using the secret key
  def sign(string)
    @commands[:sign] = string
    self
  end
  alias :secretkey :sign

  # Fix invalid file names in a bucket
  def fixbucket(bucket = nil)
    @commands[:fixbucket] = @bucket || bucket
    self
  end
  alias :fix :fixbucket
end
