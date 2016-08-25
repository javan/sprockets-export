require "test_helper"

class BundleProcessorTest < Sprockets::Export::TestCase
  def setup
    @env = Sprockets::Environment.new(".")
    @env.append_path File.expand_path("../fixtures", __FILE__)
  end

  test "javascript asset with export directive" do
    assert_equal <<-JS,  @env["package.js"].to_s
(function() {
  var context = this;

  (function() {
    this.MyPackage = {
      version: 1
    }
  }).call(context);

  var MyPackage = context.MyPackage;

  (function() {
    MyPackage.a = "a"
    ;
    MyPackage.b = "b"
  }).call(this);

  if (typeof module === "object" && module.exports) {
    module.exports = MyPackage;
  } else if (typeof define === "function" && define.amd) {
    define(MyPackage);
  }
}).call(this);
    JS
  end

  test "javascript asset with export and noglobal directive" do
    assert_equal <<-JS,  @env["package-noglobal.js"].to_s
(function() {
  var context = {};

  (function() {
    this.MyPackage = {
      version: 1
    }
  }).call(context);

  var MyPackage = context.MyPackage;

  (function() {
    MyPackage.a = "a"
    ;
    MyPackage.b = "b"
  }).call(this);

  if (typeof module === "object" && module.exports) {
    module.exports = MyPackage;
  } else if (typeof define === "function" && define.amd) {
    define(MyPackage);
  }
}).call(this);
    JS
  end

  test "javascript asset with data before export directive" do
    assert_equal <<-JS,  @env["head-export-tail.js"].to_s
head();

(function() {
  var context = this;

  (function() {
    this.Foo = function() {};
  }).call(context);

  var Foo = context.Foo;

  (function() {
    new Foo();
    tail();
  }).call(this);

  if (typeof module === "object" && module.exports) {
    module.exports = Foo;
  } else if (typeof define === "function" && define.amd) {
    define(Foo);
  }
}).call(this);
    JS
  end

  test "non-javascript assets ignore export directive" do
    assert_equal "body { display: none; }\n\n\n\n", @env["styles.css"].to_s
  end
end
