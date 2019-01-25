# GitHub Issue Collator

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

The GitHub Issue Collator collates issues from all your GitHub repos into one place.

## Technical implementation

GitHub Issue Collator is a Ruby app using the [Sinatra](http://sinatrarb.com) framework.

### Prerequisites

* Ruby 2.5.3
* rbenv or another way of managing Ruby versions
* A GitHub account with a [personal access token](https://github.com/settings/tokens) (with the `repo` permission)

### Environment variables

* `GITHUB_ACCESS_TOKEN`: A GitHub personal access token that has read access to all your repositories
* `AUTH_USERNAME`: Set to a username to log in to the app
* `AUTH_PASSWORD`: Set to a password to log in to the app

## Running the application

```
$ bundle exec puma -C ./config/puma.rb
```

## Running the app tests

```
$ bundle exec rake
```
for running the RSpec and linting tests.

## Installing dependencies in development

```
$ bundle install --without production
```

## Licence

[MIT licence](LICENCE)
