require "test_helper"

class VersionTest < ActiveSupport::TestCase
  test 'project versions in all files match each other' do
    version_containing_files = {
      'package.json' => package_json_version(File.join(Rails.root, 'package.json'))
    }

    current_app_version = Rails.application.config.application_version

    version_containing_files.each do |_file_name, file_name_app_version|
      assert_equal(current_app_version, file_name_app_version)
    end
  end

  private

  def package_json_version(file_path)
    package_json_data = JSON.parse(File.read(file_path))

    package_json_data['version']
  end
end