namespace :version do
  desc 'Display current application version'
  task :display do
    puts Rails.application.config.application_version
  end
end
