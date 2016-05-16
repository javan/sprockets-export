require "sprockets/export/version"
require "sprockets/export/directive_processor"
require "sprockets/export/metadata_injector"
require "sprockets/export/bundle_processor"

module Sprockets
  module Export
    def self.asset_path
      @asset_path ||= Pathname.new(__dir__).join("../../assets")
    end
  end
end

Sprockets.append_path Sprockets::Export.asset_path
Sprockets.register_postprocessor    "application/javascript", Sprockets::Export::MetadataInjector
Sprockets.register_bundle_processor "application/javascript", Sprockets::Export::BundleProcessor
