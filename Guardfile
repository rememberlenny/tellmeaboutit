guard :minitest, spring: true, all_on_start: false do
  watch(%r{^spec/(.*)/?(.*)_spec\.rb$})
  watch('spec/spec_helper.rb') { 'spec' }
  watch('config/routes.rb')    { integration_tests }
  watch(%r{^app/models/(.*?)\.rb$}) do |matches|
    "spec/models/#{matches[1]}_spec.rb"
  end
  watch(%r{^app/controllers/(.*?)_controller\.rb$}) do |matches|
    resource_tests(matches[1])
  end
  watch(%r{^app/views/([^/]*?)/.*\.html\.erb$}) do |matches|
    ["spec/controllers/#{matches[1]}_controller_spec.rb"] +
    integration_tests(matches[1])
  end
  watch(%r{^app/helpers/(.*?)_helper\.rb$}) do |matches|
    integration_tests(matches[1])
  end
  watch('app/views/layouts/application.html.erb') do
    'spec/integration/site_layout_spec.rb'
  end
  watch('app/helpers/sessions_helper.rb') do
    integration_tests << 'spec/helpers/sessions_helper_spec.rb'
  end
  watch('app/controllers/sessions_controller.rb') do
    ['spec/controllers/sessions_controller_spec.rb',
     'spec/integration/users_login_spec.rb']
  end
  watch('app/controllers/account_activations_controller.rb') do
    'spec/integration/users_signup_spec.rb'
  end
  watch(%r{app/views/users/*}) do
    resource_tests('users') +
    ['spec/integration/microposts_interface_spec.rb']
  end
end

# Returns the integration tests corresponding to the given resource.
def integration_tests(resource = :all)
  if resource == :all
    Dir["spec/integration/*"]
  else
    Dir["spec/integration/#{resource}_*.rb"]
  end
end

# Returns the controller tests corresponding to the given resource.
def controller_test(resource)
  "spec/controllers/#{resource}_controller_spec.rb"
end

# Returns all tests for the given resource.
def resource_tests(resource)
  integration_tests(resource) << controller_spec(resource)
end
