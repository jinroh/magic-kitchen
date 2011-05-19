# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{cancan}
  s.version = "1.6.4"

  s.required_rubygems_version = Gem::Requirement.new(">= 1.3.4") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Bates"]
  s.date = %q{2011-03-29}
  s.description = %q{Simple authorization solution for Rails which is decoupled from user roles. All permissions are stored in a single location.}
  s.email = %q{ryan@railscasts.com}
  s.homepage = %q{http://github.com/ryanb/cancan}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{cancan}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Simple authorization solution for Rails.}

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, ["~> 2.1.0"])
      s.add_development_dependency(%q<rails>, ["~> 3.0.0"])
      s.add_development_dependency(%q<rr>, ["~> 0.10.11"])
      s.add_development_dependency(%q<supermodel>, ["~> 0.1.4"])
    else
      s.add_dependency(%q<rspec>, ["~> 2.1.0"])
      s.add_dependency(%q<rails>, ["~> 3.0.0"])
      s.add_dependency(%q<rr>, ["~> 0.10.11"])
      s.add_dependency(%q<supermodel>, ["~> 0.1.4"])
    end
  else
    s.add_dependency(%q<rspec>, ["~> 2.1.0"])
    s.add_dependency(%q<rails>, ["~> 3.0.0"])
    s.add_dependency(%q<rr>, ["~> 0.10.11"])
    s.add_dependency(%q<supermodel>, ["~> 0.1.4"])
  end
end
