require "pathname"

require "sprockets"
require "sprockets/export/version"
require "sprockets/export/store"
require "sprockets/export/directive_processor"
require "sprockets/export/metadata_injector"
require "sprockets/export/bundle_processor"

module Sprockets::Export
  def self.lib_path
    @lib_path ||= Pathname.new(File.expand_path("../..", __FILE__))
  end
end


Sprockets.append_path Sprockets::Export.lib_path
Sprockets.register_postprocessor    "application/javascript", Sprockets::Export::MetadataInjector
Sprockets.register_bundle_processor "application/javascript", Sprockets::Export::BundleProcessor
