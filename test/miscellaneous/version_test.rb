require "test_helper"

class VersionTest < ActiveSupport::TestCase
  CHANGELOG_VERSION_SEQUENCE = '## '
  TRACKED_CHANGELOG_LINE_COUNT = 2

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

    last, penultimate = latest_changelogs(changelog_file_path).map{|line| ChangelogVersion.new(line)}

    assert_equal @current_app_version, last.to_s

    assert last > penultimate, "Latest version #{last} is not greater than next older version #{penultimate}"
  end

  private

  def latest_changelogs(file_path)
    tested_changelog_lines = []

    File.foreach(file_path) do |line|
      if line.starts_with?(CHANGELOG_VERSION_SEQUENCE)
        tested_changelog_lines.push(parse_changelog_version(line))

        return tested_changelog_lines if tested_changelog_lines.length >= TRACKED_CHANGELOG_LINE_COUNT
      end
    end

    tested_changelog_lines
  end

  def parse_changelog_version(changelog_version_line)
    _line_starter, version = changelog_version_line.split(/\s+/)

    version
  end

  def package_json_version(file_path)
    package_json_data = JSON.parse(File.read(file_path))

    package_json_data['version']
  end

  class ChangelogVersion
    include Comparable

    attr_accessor :major, :minor, :patch, :hotfix

    def initialize(version_str)
      @major, @minor, @patch, @hotfix = version_str.split('.').map(&:to_i)
    end

    def self.v0
      ChangelogVersion.new('0.0.0.0')
    end

    def <=>(other_version)
      self.to_s <=> other_version.to_s
    end

    def to_s
      [major, minor, patch, hotfix].compact.join('.')
    end
  end
end
