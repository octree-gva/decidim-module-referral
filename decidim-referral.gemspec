# frozen_string_literal: true

$LOAD_PATH.push File.expand_path("lib", __dir__)

require "decidim/referral/version"

Gem::Specification.new do |s|
  s.version = Decidim::Referral.version
  s.authors = ["Hadrien Froger"]
  s.email = ["hadrien@octree.ch"]
  s.license = "AGPL-3.0"
  s.homepage = "https://github.com/octree-gva/decidim-module-referral"
  s.required_ruby_version = ">= 2.7"

  s.name = "decidim-referral"
  s.summary = "A decidim referral module"
  s.description = "Custom registration flow for Mkutano's Decidim."

  s.files = Dir["{app,config,lib}/**/*", "LICENSE.md", "Rakefile", "README.md"]

  s.add_dependency "decidim-core", Decidim::Referral.version
end
