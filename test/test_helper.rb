require 'test/unit'
Dir[File.join(File.dirname(__FILE__), '/../lib/*.rb')].sort.reverse.each { |lib| require lib }

class TestClass; end
def test_class(method_name, &block)
  TestClass.class_eval do
    include S3Cmd
    define_method(method_name) do
      self.instance_eval(&block)
    end
  end
end
