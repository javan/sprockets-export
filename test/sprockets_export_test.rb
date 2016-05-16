require "test_helper"

class BundleProcessorTest < Sprockets::Export::TestCase
  def setup
    @env = Sprockets::Environment.new(".")
    @env.append_path File.join(__dir__, "fixtures")
  end

  test "javascript asset with export_self directive" do
    assert_equal <<-JS,  @env["package.js"].to_s
(function() {
  (function() {
    this.MyPackage = {
      version: 1
    }
  }).call(this);

  eval("var MyPackage = this.MyPackage");

  (function() {
    MyPackage.a = "a"
    ;
    MyPackage.b = "b"
  }).call(this);

  if (typeof module === "object" && module.exports && false) {
    module.exports = MyPackage;
  } else if (typeof define === "function" && define.amd) {
    define(MyPackage);
  }
}).call(this);
    JS
  end
end
