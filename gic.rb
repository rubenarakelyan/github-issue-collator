require 'sinatra'
require_relative 'lib/github_issues'

helpers do
  def user_protected!
    return if user_authorized?

    headers['WWW-Authenticate'] = 'Basic realm="GitHub Issue Collator"'
    halt 401
  end

  def user_authorized?
    @auth ||= Rack::Auth::Basic::Request.new(request.env)
    @auth.provided? && @auth.basic? && @auth.credentials && @auth.credentials == [ENV['AUTH_USERNAME'], ENV['AUTH_PASSWORD']]
  end
end

raise 'The AUTH_USERNAME and AUTH_PASSWORD environment variables must be set to run this application.' unless ENV['AUTH_USERNAME'] && ENV['AUTH_PASSWORD']

get '/' do
  user_protected!
  issues_list = GitHubIssues.new.issues_list
  erb :index, locals: { issues_list: issues_list }
end
