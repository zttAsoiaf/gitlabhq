module Gitlab
  module GithubImport
    class BaseFormatter
      attr_reader :client, :formatter, :project, :raw_data

      def initialize(project, raw_data, client = nil)
        @project = project
        @raw_data = raw_data
        @client = client
        @formatter = Gitlab::ImportFormatter.new
      end

      def create!
        project.public_send(project_association).find_or_create_by!(find_condition) do |record|
          record.attributes = attributes
        end
      end

      def url
        raw_data.url || ''
      end
    end
  end
end
