S3Cmd-DSL
=========

`s3cmd-dsl` is a gem providing a complete ruby DSL interface to s3cmd Amazon S3 client.

It supports the following:

 * a complete DSL for Amazon S3.
 * covers s3cmd version 1.0.1
 * supports method-chaining
 * supports one-liner for quick and easy s3cmd tasks
 * backed with full-test coverage
 * organize your scripts and save them
 * offers an `execute` method to execute the tasks right away

To install, type `gem install s3cmd-dsl`

Usage:

    require 's3cmd-dsl'
    include S3Cmd

    # For quick usage in one-line. Passing 'execute' executes the command.
    s3cmd('List all buckets', 'ls', 'execute')

    # Or do it this way
    s3cmd 'List all buckets' do
      path '/usr/local/bin/s3cmd'
      ls 's3://BUCKET'
      save_script('list_all_buckets.sh')
      execute
    end

    # When passing parameters
    s3cmd 'List all buckets' do
      path '/usr/local/bin/s3cmd'
      sync '/local/path', 's3://BUCKET'
      rinclude '[0-9].*.jpg'
      exclude '*.jpg'
      config '/etc/my_s3cmd_config.cfg'
      save_script('list_all_buckets.sh')
      execute
    end

    s3cmd 'Get Files (Example 2)' do
      get 's3://BUCKET', '/tmp'
      recursive
    end

    # And using the 'bucket' or 'files' keyword
    s3cmd 'List all buckets' do
      path '/usr/local/bin/s3cmd'
      bucket 's3://BUCKET'
      ls
    end

    # Or chain all the methods
    s3cmd do
      path('/usr/local/bin/s3cmd').bucket('s3://BUCKET').config('/etc/my_s3cmd_config.cfg').save_script('list_all_buckets.sh').execute
    end

    # or using 'files'
    filelist = ['file1', 'file2']
    s3cmd('Upload filelist to bucket') do
      path 'test-s3cmd'
      files filelist
      bucket 's3://BUCKET'
      put
    end


[![Bitdeli Badge](https://d2weczhvl823v0.cloudfront.net/jjuliano/s3cmd-dsl/trend.png)](https://bitdeli.com/free "Bitdeli Badge")

