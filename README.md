S3Cmd-DSL - Amazon S3 Toolkit for Ruby
======================================

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

### Why S3Cmd-DSL?
S3Cmd-DSL creates simple and small development tools that help you design,
develop, deploy cloud infrastractures for your enterprise software systems.

#### S3Cmd-DSL Pro: A Commercial, Supported Version of S3Cmd-DSL
S3Cmd-DSL Pro is a collection of useful functionality for the open source S3Cmd-DSL library with priority support via Remote access or Skype from the author, new features in-demand, upgrades and lots more.

Sales of S3Cmd-DSL Pro also benefit the community by ensuring that S3Cmd-DSL itself will remain well supported for the foreseeable future.

#### Licensing
S3Cmd-DSL is available under the terms of the GNU LGPLv3 license.

In addition to its useful functionality, buying S3Cmd-DSL Pro grants your organization a S3Cmd-DSL Commercial License instead of the GNU LGPL, avoiding any legal issues your lawyers might raise. Please contact joelbryan.juliano@gmail.com for further detail on licensing including options for embedding S3Cmd-DSL Pro in your own products.

#### Buy S3Cmd-DSL Pro
Contact me via joelbryan.juliano@gmail.com, and Pay via Paypal: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=6MLTH5P4SELAU

# Usage:

```ruby
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
```

### Donations

Please support independent cloud computing toolkits, also money donated to the project will benefit the community by ensuring that S3Cmd-DSL itself will remain well supported for the foreseeable future. To Donate, please visit: https://www.paypal.com/cgi-bin/webscr?cmd=_s-xclick&hosted_button_id=KT9CY4T7BYDM4
