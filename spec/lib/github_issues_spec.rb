require_relative '../../lib/github_issues'

RSpec.describe GitHubIssues, '#issues_list' do
  before do
    ENV['GITHUB_ACCESS_TOKEN'] = 'fake'
  end

  context 'if there are no issues' do
    it 'returns an empty array' do
      stub_request(:get, 'https://api.github.com/user/issues?filter=created&per_page=100')
        .to_return(body: '[]', headers: { content_type: 'application/json' })
      github_issues = GitHubIssues.new
      expect(github_issues.issues_list).to eq([])
    end
  end

  context 'if there are some issues' do
    it 'returns an array of issue hashes' do
      stub_request(:get, 'https://api.github.com/user/issues?filter=created&per_page=100')
        .to_return(body: File.read('spec/fixtures/github_issues_response.json'), headers: { content_type: 'application/json' })
      github_issues = GitHubIssues.new
      expect(github_issues.issues_list).to eq(
        [
          {
            title: 'Make this repo organisation-neutral',
            body: 'Currently this repo is oriented towards GDS since it contains configuration with our teams. We now have a fork at https://github.com/alphagov/seal which should contain our configuration. With that, this repo can now be made organisation-neutral so that there isn\'t any confusion about whether others can run it or not.',
            repo_name: 'binaryberry/seal',
            url: 'https://api.github.com/repos/binaryberry/seal/issues/285'
          }
        ]
      )
    end
  end
end
