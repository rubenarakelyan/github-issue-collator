require 'octokit'

class GitHubIssues
  def initialize
    raise 'The GITHUB_ACCESS_TOKEN environment variable must be set to run this application.' unless ENV['GITHUB_ACCESS_TOKEN']

    @client = Octokit::Client.new(access_token: ENV['GITHUB_ACCESS_TOKEN'])
    @client.auto_paginate = true
  end

  def issues_list
    issues.map do |issue|
      {
        title: issue[:title],
        body: issue[:body],
        repo_name: issue[:repository][:full_name],
        url: issue[:url]
      }
    end
  end

  private

  def issues
    @client.user_issues(filter: 'created')
  end
end
