# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{awesome_print}
  s.version = "0.3.2"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Michael Dvorkin"]
  s.date = %q{2011-02-02}
  s.description = %q{Great Ruby dubugging companion: pretty print Ruby objects to visualize their structure. Supports Rails ActiveRecord objects via included mixin.}
  s.email = %q{mike@dvorkin.net}
  s.files = ["spec/action_view_spec.rb", "spec/active_record_spec.rb", "spec/awesome_print_spec.rb", "spec/logger_spec.rb", "spec/methods_spec.rb", "spec/spec_helper.rb", "spec/string_spec.rb"]
  s.homepage = %q{http://github.com/michaeldv/awesome_print}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{awesome_print}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Pretty print Ruby objects with proper indentation and colors.}
  s.test_files = ["spec/action_view_spec.rb", "spec/active_record_spec.rb", "spec/awesome_print_spec.rb", "spec/logger_spec.rb", "spec/methods_spec.rb", "spec/spec_helper.rb", "spec/string_spec.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_development_dependency(%q<rspec>, [">= 1.3.0"])
    else
      s.add_dependency(%q<rspec>, [">= 1.3.0"])
    end
  else
    s.add_dependency(%q<rspec>, [">= 1.3.0"])
  end
end
