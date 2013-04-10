require_relative 'test_helper'
class TestS3CmdDSLGeneral < Test::Unit::TestCase
  def test_with_params
    test_class('test_with_params') {
      s3cmd('Test With Parameters') do
        path 'test-s3cmd'
        mb 's3://BUCKET'
      end
    }

    klass = TestClass.new
    assert_equal('test-s3cmd mb s3://BUCKET',  klass.test_with_params)
  end

  def test_without_params
    test_class('test_without_params') {
      s3cmd('Test Without Parameters') do
        path 'test-s3cmd'
        bucket 's3://BUCKET'
        mb
      end
    }

    klass = TestClass.new
    assert_equal('test-s3cmd mb s3://BUCKET',  klass.test_without_params)
  end

  def test_with_keywords
    test_class('test_with_keywords') {
      s3cmd('Test With Keywords') do
        path 'test-s3cmd'
        ls 's3://BUCKET'
        rinclude '[0-9].*.jpg'
        exclude '*.jpg'
      end
    }

    klass = TestClass.new
    assert_equal('test-s3cmd ls s3://BUCKET --rinclude [0-9].*.jpg --exclude *.jpg',  klass.test_with_keywords)
  end

  def test_one_liner
    test_class('test_one_liner') { s3cmd('Test One Liner', 'configure') }

    klass = TestClass.new
    s3cmd_path = `which s3cmd`.strip!
    path = s3cmd_path.nil? ? 's3cmd' : s3cmd_path
    assert_equal("#{path} --configure",  klass.test_one_liner)
  end

  def test_chaining
    test_class('test_chaining') {
      s3cmd('Test Chaining') { path('test-s3cmd').ls('s3://BUCKET').rinclude('[0-9].*.jpg').exclude('*.jpg') }
    }

    klass = TestClass.new
    assert_equal('test-s3cmd ls s3://BUCKET --rinclude [0-9].*.jpg --exclude *.jpg',  klass.test_chaining)
  end

  def test_path
    test_class('test_path') {
      s3cmd('Test Path') { ls }
    }

    klass = TestClass.new
    s3cmd_path = `which s3cmd`.strip!
    path = s3cmd_path.nil? ? 's3cmd' : s3cmd_path
    assert_equal("#{path} ls",  klass.test_path)
  end

  def test_cloudfront_methods
    test_class('test_cloudfront_methods') {
      s3cmd('Test CloudFront Methods') { cflist }
    }

    klass = TestClass.new
    s3cmd_path = `which s3cmd`.strip!
    path = s3cmd_path.nil? ? 's3cmd' : s3cmd_path
    assert_equal("#{path} cflist",  klass.test_cloudfront_methods)
  end

  def test_files_parameter
    test_class('test_files_parameter') {
      filelist = ['file1', 'file2']
      s3cmd('Test Files Parameter') do
        path 'test-s3cmd'
        files filelist
        bucket 's3://BUCKET'
        put
      end
    }

    klass = TestClass.new
    assert_equal("test-s3cmd put file1 file2 s3://BUCKET", klass.test_files_parameter)
  end

  COMMANDS = [:mb, :rb, :ls, :del, :setacl, :info, :du, :accesslog, :fixbucket]

  # Test with Parameters
  COMMANDS.each do |command|
    meth = %Q{
      def test_#{command.to_s}_with_params
        test_class("test_#{command.to_s}_with_params") {
          s3cmd("Test #{command.to_s} With Parameters") do
            path 'test-s3cmd'
            #{command.to_s} 's3://BUCKET'
          end
        }

        klass = TestClass.new
        assert_equal("test-s3cmd #{command.to_s} s3://BUCKET",  klass.test_#{command.to_s}_with_params)
      end
    }
    eval(meth)
  end

  # Test without parameters
  COMMANDS.each do |command|
    meth = %Q{
      def test_#{command.to_s}_without_params
        test_class("test_#{command.to_s}_without_params") {
          s3cmd("Test #{command.to_s} Without Parameters") do
            path 'test-s3cmd'
            bucket 's3://BUCKET'
            #{command.to_s}
          end
        }

        klass = TestClass.new
        assert_equal("test-s3cmd #{command.to_s} s3://BUCKET",  klass.test_#{command.to_s}_without_params)
      end
    }
    eval(meth)
  end

  # Test with parameters and passing arguments
  COMMANDS.each do |command|
    meth = %Q{
      def test_#{command.to_s}_with_params_and_arguments
        test_class("test_#{command.to_s}_with_params_and_arguments") {
          s3cmd("Test #{command.to_s} With Parameters") do
            path 'test-s3cmd'
            #{command.to_s} 's3://BUCKET'
            recursive
            encoding 'utf-8'
          end
        }

        klass = TestClass.new
        assert_equal("test-s3cmd #{command.to_s} s3://BUCKET --recursive  --encoding utf-8",  klass.test_#{command.to_s}_with_params_and_arguments)
      end
    }
    eval(meth)
  end

  # Test without parameters and passing arguments
  COMMANDS.each do |command|
    meth = %Q{
      def test_#{command.to_s}_without_params_and_arguments
        test_class("test_#{command.to_s}_without_params_and_arguments") {
          s3cmd("Test #{command.to_s} Without Parameters") do
            path 'test-s3cmd'
            bucket 's3://BUCKET'
            #{command.to_s}
            recursive
            encoding 'utf-8'
          end
        }

        klass = TestClass.new
        assert_equal("test-s3cmd #{command.to_s} s3://BUCKET --recursive  --encoding utf-8",  klass.test_#{command.to_s}_without_params_and_arguments)
      end
    }
    eval(meth)
  end

  # Test chaining with parameters and passing arguments
  COMMANDS.each do |command|
    meth = %Q{
      def test_chaining_#{command.to_s}_with_params_and_arguments
        test_class("test_chaining_#{command.to_s}_with_params_and_arguments") {
          s3cmd("Test #{command.to_s} With Parameters") do
            path('test-s3cmd').#{command.to_s}('s3://BUCKET').recursive.encoding('utf-8')
          end
        }

        klass = TestClass.new
        assert_equal("test-s3cmd #{command.to_s} s3://BUCKET --recursive  --encoding utf-8",  klass.test_chaining_#{command.to_s}_with_params_and_arguments)
      end
    }
    eval(meth)
  end

  # Test chaining without parameters and passing arguments
  COMMANDS.each do |command|
    meth = %Q{
      def test_chaining_#{command.to_s}_without_params_and_arguments
        test_class("test_chaining_#{command.to_s}_without_params_and_arguments") {
          s3cmd("Test #{command.to_s} Without Parameters") do
            path('test-s3cmd').bucket('s3://BUCKET').#{command.to_s}.recursive.encoding('utf-8')
          end
        }

        klass = TestClass.new
        assert_equal("test-s3cmd #{command.to_s} s3://BUCKET --recursive  --encoding utf-8",  klass.test_chaining_#{command.to_s}_without_params_and_arguments)
      end
    }
    eval(meth)
  end
end
