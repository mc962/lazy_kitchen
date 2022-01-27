require "test_helper"

class VersionTest < ActiveSupport::TestCase
  CHANGELOG_VERSION_SEQUENCE = '## '

  setup do
    @current_app_version = Rails.application.config.application_version
  end

  test 'project versions in all files match each other' do
    version_containing_files = {
      'package.json' => package_json_version(File.join(Rails.root, 'package.json'))
    }


    version_containing_files.each do |_file_name, file_name_app_version|
      assert_equal(@current_app_version, file_name_app_version)
    end
  end

  test 'project version has a matching entry in the CHANGELOG' do
    changelog_file_path = File.join(Rails.root, 'CHANGELOG.md')

    assert File.exist?(changelog_file_path)

    assert_equal @current_app_version, latest_changelog(changelog_file_path)
  end

  private

  def latest_changelog(file_path)
    File.foreach(file_path) do |line|
      if line.starts_with?(CHANGELOG_VERSION_SEQUENCE)
        return parse_changelog_version(line)
      end
    end
  end

  def parse_changelog_version(changelog_version_line)
    _line_starter, version = changelog_version_line.split(/\s+/)

    version
  end

  def package_json_version(file_path)
    package_json_data = JSON.parse(File.read(file_path))

    package_json_data['version']
  end
end