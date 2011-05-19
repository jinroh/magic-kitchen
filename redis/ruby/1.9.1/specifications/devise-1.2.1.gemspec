# -*- encoding: utf-8 -*-

Gem::Specification.new do |s|
  s.name = %q{devise}
  s.version = "1.2.1"

  s.required_rubygems_version = Gem::Requirement.new(">= 0") if s.respond_to? :required_rubygems_version=
  s.authors = ["José Valim", "Carlos Antônio"]
  s.date = %q{2011-03-28}
  s.description = %q{Flexible authentication solution for Rails with Warden}
  s.email = %q{contact@plataformatec.com.br}
  s.files = ["test/controllers/helpers_test.rb", "test/controllers/internal_helpers_test.rb", "test/controllers/url_helpers_test.rb", "test/devise_test.rb", "test/encryptors_test.rb", "test/failure_app_test.rb", "test/generators/active_record_generator_test.rb", "test/generators/devise_generator_test.rb", "test/generators/install_generator_test.rb", "test/generators/mongoid_generator_test.rb", "test/generators/views_generator_test.rb", "test/indifferent_hash.rb", "test/integration/authenticatable_test.rb", "test/integration/confirmable_test.rb", "test/integration/database_authenticatable_test.rb", "test/integration/http_authenticatable_test.rb", "test/integration/lockable_test.rb", "test/integration/omniauthable_test.rb", "test/integration/recoverable_test.rb", "test/integration/registerable_test.rb", "test/integration/rememberable_test.rb", "test/integration/timeoutable_test.rb", "test/integration/token_authenticatable_test.rb", "test/integration/trackable_test.rb", "test/mailers/confirmation_instructions_test.rb", "test/mailers/reset_password_instructions_test.rb", "test/mailers/unlock_instructions_test.rb", "test/mapping_test.rb", "test/models/confirmable_test.rb", "test/models/database_authenticatable_test.rb", "test/models/encryptable_test.rb", "test/models/lockable_test.rb", "test/models/recoverable_test.rb", "test/models/rememberable_test.rb", "test/models/timeoutable_test.rb", "test/models/token_authenticatable_test.rb", "test/models/trackable_test.rb", "test/models/validatable_test.rb", "test/models_test.rb", "test/omniauth/url_helpers_test.rb", "test/orm/active_record.rb", "test/orm/mongoid.rb", "test/rails_app/Rakefile", "test/rails_app/app/active_record/admin.rb", "test/rails_app/app/active_record/shim.rb", "test/rails_app/app/active_record/user.rb", "test/rails_app/app/controllers/admins/sessions_controller.rb", "test/rails_app/app/controllers/admins_controller.rb", "test/rails_app/app/controllers/application_controller.rb", "test/rails_app/app/controllers/home_controller.rb", "test/rails_app/app/controllers/publisher/registrations_controller.rb", "test/rails_app/app/controllers/publisher/sessions_controller.rb", "test/rails_app/app/controllers/users/omniauth_callbacks_controller.rb", "test/rails_app/app/controllers/users_controller.rb", "test/rails_app/app/helpers/application_helper.rb", "test/rails_app/app/mongoid/admin.rb", "test/rails_app/app/mongoid/shim.rb", "test/rails_app/app/mongoid/user.rb", "test/rails_app/app/views/admins/index.html.erb", "test/rails_app/app/views/admins/sessions/new.html.erb", "test/rails_app/app/views/home/index.html.erb", "test/rails_app/app/views/home/private.html.erb", "test/rails_app/app/views/layouts/application.html.erb", "test/rails_app/app/views/users/index.html.erb", "test/rails_app/app/views/users/mailer/confirmation_instructions.erb", "test/rails_app/app/views/users/sessions/new.html.erb", "test/rails_app/config.ru", "test/rails_app/config/application.rb", "test/rails_app/config/boot.rb", "test/rails_app/config/database.yml", "test/rails_app/config/environment.rb", "test/rails_app/config/environments/development.rb", "test/rails_app/config/environments/production.rb", "test/rails_app/config/environments/test.rb", "test/rails_app/config/initializers/backtrace_silencers.rb", "test/rails_app/config/initializers/devise.rb", "test/rails_app/config/initializers/inflections.rb", "test/rails_app/config/initializers/secret_token.rb", "test/rails_app/config/routes.rb", "test/rails_app/db/migrate/20100401102949_create_tables.rb", "test/rails_app/db/schema.rb", "test/rails_app/lib/shared_admin.rb", "test/rails_app/lib/shared_user.rb", "test/rails_app/public/404.html", "test/rails_app/public/422.html", "test/rails_app/public/500.html", "test/rails_app/public/favicon.ico", "test/rails_app/script/rails", "test/routes_test.rb", "test/schema_test.rb", "test/support/assertions.rb", "test/support/helpers.rb", "test/support/integration.rb", "test/support/locale/en.yml", "test/support/webrat/integrations/rails.rb", "test/test_helper.rb", "test/test_helpers_test.rb"]
  s.homepage = %q{http://github.com/plataformatec/devise}
  s.require_paths = ["lib"]
  s.rubyforge_project = %q{devise}
  s.rubygems_version = %q{1.6.2}
  s.summary = %q{Flexible authentication solution for Rails with Warden}
  s.test_files = ["test/controllers/helpers_test.rb", "test/controllers/internal_helpers_test.rb", "test/controllers/url_helpers_test.rb", "test/devise_test.rb", "test/encryptors_test.rb", "test/failure_app_test.rb", "test/generators/active_record_generator_test.rb", "test/generators/devise_generator_test.rb", "test/generators/install_generator_test.rb", "test/generators/mongoid_generator_test.rb", "test/generators/views_generator_test.rb", "test/indifferent_hash.rb", "test/integration/authenticatable_test.rb", "test/integration/confirmable_test.rb", "test/integration/database_authenticatable_test.rb", "test/integration/http_authenticatable_test.rb", "test/integration/lockable_test.rb", "test/integration/omniauthable_test.rb", "test/integration/recoverable_test.rb", "test/integration/registerable_test.rb", "test/integration/rememberable_test.rb", "test/integration/timeoutable_test.rb", "test/integration/token_authenticatable_test.rb", "test/integration/trackable_test.rb", "test/mailers/confirmation_instructions_test.rb", "test/mailers/reset_password_instructions_test.rb", "test/mailers/unlock_instructions_test.rb", "test/mapping_test.rb", "test/models/confirmable_test.rb", "test/models/database_authenticatable_test.rb", "test/models/encryptable_test.rb", "test/models/lockable_test.rb", "test/models/recoverable_test.rb", "test/models/rememberable_test.rb", "test/models/timeoutable_test.rb", "test/models/token_authenticatable_test.rb", "test/models/trackable_test.rb", "test/models/validatable_test.rb", "test/models_test.rb", "test/omniauth/url_helpers_test.rb", "test/orm/active_record.rb", "test/orm/mongoid.rb", "test/rails_app/Rakefile", "test/rails_app/app/active_record/admin.rb", "test/rails_app/app/active_record/shim.rb", "test/rails_app/app/active_record/user.rb", "test/rails_app/app/controllers/admins/sessions_controller.rb", "test/rails_app/app/controllers/admins_controller.rb", "test/rails_app/app/controllers/application_controller.rb", "test/rails_app/app/controllers/home_controller.rb", "test/rails_app/app/controllers/publisher/registrations_controller.rb", "test/rails_app/app/controllers/publisher/sessions_controller.rb", "test/rails_app/app/controllers/users/omniauth_callbacks_controller.rb", "test/rails_app/app/controllers/users_controller.rb", "test/rails_app/app/helpers/application_helper.rb", "test/rails_app/app/mongoid/admin.rb", "test/rails_app/app/mongoid/shim.rb", "test/rails_app/app/mongoid/user.rb", "test/rails_app/app/views/admins/index.html.erb", "test/rails_app/app/views/admins/sessions/new.html.erb", "test/rails_app/app/views/home/index.html.erb", "test/rails_app/app/views/home/private.html.erb", "test/rails_app/app/views/layouts/application.html.erb", "test/rails_app/app/views/users/index.html.erb", "test/rails_app/app/views/users/mailer/confirmation_instructions.erb", "test/rails_app/app/views/users/sessions/new.html.erb", "test/rails_app/config.ru", "test/rails_app/config/application.rb", "test/rails_app/config/boot.rb", "test/rails_app/config/database.yml", "test/rails_app/config/environment.rb", "test/rails_app/config/environments/development.rb", "test/rails_app/config/environments/production.rb", "test/rails_app/config/environments/test.rb", "test/rails_app/config/initializers/backtrace_silencers.rb", "test/rails_app/config/initializers/devise.rb", "test/rails_app/config/initializers/inflections.rb", "test/rails_app/config/initializers/secret_token.rb", "test/rails_app/config/routes.rb", "test/rails_app/db/migrate/20100401102949_create_tables.rb", "test/rails_app/db/schema.rb", "test/rails_app/lib/shared_admin.rb", "test/rails_app/lib/shared_user.rb", "test/rails_app/public/404.html", "test/rails_app/public/422.html", "test/rails_app/public/500.html", "test/rails_app/public/favicon.ico", "test/rails_app/script/rails", "test/routes_test.rb", "test/schema_test.rb", "test/support/assertions.rb", "test/support/helpers.rb", "test/support/integration.rb", "test/support/locale/en.yml", "test/support/webrat/integrations/rails.rb", "test/test_helper.rb", "test/test_helpers_test.rb"]

  if s.respond_to? :specification_version then
    s.specification_version = 3

    if Gem::Version.new(Gem::VERSION) >= Gem::Version.new('1.2.0') then
      s.add_runtime_dependency(%q<warden>, ["~> 1.0.3"])
      s.add_runtime_dependency(%q<orm_adapter>, ["~> 0.0.3"])
      s.add_runtime_dependency(%q<bcrypt-ruby>, ["~> 2.1.2"])
    else
      s.add_dependency(%q<warden>, ["~> 1.0.3"])
      s.add_dependency(%q<orm_adapter>, ["~> 0.0.3"])
      s.add_dependency(%q<bcrypt-ruby>, ["~> 2.1.2"])
    end
  else
    s.add_dependency(%q<warden>, ["~> 1.0.3"])
    s.add_dependency(%q<orm_adapter>, ["~> 0.0.3"])
    s.add_dependency(%q<bcrypt-ruby>, ["~> 2.1.2"])
  end
end
