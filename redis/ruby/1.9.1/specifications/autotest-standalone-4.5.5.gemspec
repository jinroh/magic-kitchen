# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{autotest-standalone}
  s.version = "4.5.5"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["Ryan Davis", "Michael Grosser"]
  s.date = %q{2011-02-04}
  s.executables = ["autotest", "unit_diff"]
  s.files = ["test/test_autotest_integration.rb", "test/helper.rb", "test/test_autotest.rb", "test/test_unit_diff.rb", "bin/autotest", "bin/unit_diff"]
  s.homepage = %q{http://github.com/grosser/autotest}
  s.require_paths = ["lib"]
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Autotest, without ZenTest}
  s.test_files = ["test/test_autotest_integration.rb", "test/helper.rb", "test/test_autotest.rb", "test/test_unit_diff.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
    else
    end
  else
  end
end
