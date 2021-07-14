# -*- encoding: utf-8 -*-
# stub: zoomus 0.7.0 ruby lib

Gem::Specification.new do |s|
  s.name = "zoomus".freeze
  s.version = "0.7.0"

  s.required_rubygems_version = Gem::Requirement.new(">= 0".freeze) if s.respond_to? :required_rubygems_version=
  s.require_paths = ["lib".freeze]
  s.authors = ["Maxim Colls".freeze]
  s.date = "2017-11-06"
  s.description = "A Ruby wrapper for zoom.us API v1".freeze
  s.email = ["collsmaxim@gmail.com".freeze]
  s.homepage = "https://github.com/mllocs/zoomus".freeze
  s.licenses = ["MIT".freeze]
  s.rubygems_version = "3.1.6".freeze
  s.summary = "zoom.us API wrapper".freeze

  s.installed_by_version = "3.1.6" if s.respond_to? :installed_by_version

  if s.respond_to? :specification_version then
    s.specification_version = 4
  end

  if s.respond_to? :add_runtime_dependency then
    s.add_runtime_dependency(%q<httparty>.freeze, ["~> 0.13"])
    s.add_runtime_dependency(%q<json>.freeze, [">= 1.8"])
    s.add_development_dependency(%q<byebug>.freeze, [">= 0"])
    s.add_development_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_development_dependency(%q<webmock>.freeze, [">= 0"])
  else
    s.add_dependency(%q<httparty>.freeze, ["~> 0.13"])
    s.add_dependency(%q<json>.freeze, [">= 1.8"])
    s.add_dependency(%q<byebug>.freeze, [">= 0"])
    s.add_dependency(%q<rspec>.freeze, [">= 0"])
    s.add_dependency(%q<webmock>.freeze, [">= 0"])
  end
end
