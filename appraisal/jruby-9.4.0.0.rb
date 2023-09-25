# TODO: Actually test JRuby 9.4

appraise 'rails61-mysql2' do
  gem 'rails', '~> 6.1.0'
  gem 'activerecord-jdbcmysql-adapter', platform: :jruby
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'net-smtp'
end

appraise 'rails61-postgres' do
  gem 'rails', '~> 6.1.0'
  gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'net-smtp'
end

appraise 'rails61-postgres-redis' do
  gem 'rails', '~> 6.1.0'
  gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby
  gem 'redis', '~> 4' # TODO: Support redis 5.x
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'net-smtp'
end

appraise 'rails61-postgres-sidekiq' do
  gem 'rails', '~> 6.1.0'
  gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby
  gem 'sidekiq', '>= 6.1.2'
  gem 'sprockets', '< 4'
  gem 'lograge', '~> 0.11'
  gem 'rails_semantic_logger', '~> 4.0'
  gem 'net-smtp'
end

appraise 'rails61-semantic-logger' do
  gem 'rails', '~> 6.1.0'
  gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby
  gem 'sprockets', '< 4'
  gem 'rails_semantic_logger', '~> 4.0'
  gem 'net-smtp'
end

appraise 'resque2-redis3' do
  gem 'redis', '< 4.0'
  gem 'resque', '>= 2.0'
end

appraise 'resque2-redis4' do
  gem 'redis', '>= 4.0'
  gem 'resque', '>= 2.0'
end

appraise 'aws' do
  gem 'aws-sdk'
  gem 'shoryuken'
end

appraise 'http' do
  gem 'elasticsearch'
  gem 'ethon'
  gem 'excon'
  gem 'faraday'
  gem 'http', '~> 4' # TODO: Completely broken with this JRuby version, this has not be validate on CI
  gem 'httpclient'
  gem 'opensearch-ruby'
  gem 'rest-client'
  gem 'stripe'
  gem 'typhoeus'
end

appraise 'relational_db' do
  gem 'activerecord', '~> 7'
  gem 'delayed_job'
  gem 'delayed_job_active_record'
  gem 'makara', '>= 0.6.0.pre' # Ruby 3 requires >= 0.6.0, which is currently in pre-release: https://rubygems.org/gems/makara/versions
  gem 'activerecord-jdbcmysql-adapter', platform: :jruby
  gem 'activerecord-jdbcpostgresql-adapter', platform: :jruby
  gem 'sequel', '~> 5.54.0' # TODO: Support sequel 5.62.0+
  gem 'jdbc-sqlite3', '>= 3.28', platform: :jruby
end

appraise 'activesupport' do
  gem 'activesupport', '~> 7'

  gem 'actionpack'
  gem 'actionview'
  gem 'active_model_serializers', '>= 0.10.0'
  gem 'grape'
  gem 'lograge'
  gem 'racecar', '>= 0.3.5'
  gem 'ruby-kafka', '>= 0.7.10'
end

appraise 'contrib' do
  gem 'concurrent-ruby'
  gem 'dalli', '>= 3.0.0'
  gem 'graphql', '>= 2.0'
  gem 'mongo', '>= 2.8.0', '< 2.15.0' # TODO: FIX TEST BREAKAGES ON >= 2.15 https://github.com/DataDog/dd-trace-rb/issues/1596
  gem 'rack'
  gem 'rack-contrib'
  gem 'rack-test'
  gem 'rake', '>= 12.3'
  gem 'resque'
  gem 'roda', '>= 2.0.0'
  gem 'semantic_logger', '~> 4.0'
  gem 'sidekiq', '~> 7'
  gem 'sneakers', '>= 2.12.0'
  gem 'sucker_punch'
  gem 'que', '>= 1.0.0'
  gem 'net-smtp'
end

[3, 4, 5].each do |n|
  appraise "redis-#{n}" do
    gem 'redis', "~> #{n}"
  end
end

appraise 'sinatra' do
  gem 'sinatra', '>= 3'
  gem 'rack-test'
end

appraise 'contrib-old' do
  gem 'dalli', '< 3.0.0'
  gem 'elasticsearch', '< 8.0.0' # Dependency elasticsearch-transport renamed to elastic-transport in >= 8.0
  gem 'graphql', '~> 1.12.0', '< 2.0' # TODO: Support graphql 1.13.x
  gem 'presto-client', '>= 0.5.14' # Renamed to trino-client in >= 1.0

  if RUBY_PLATFORM == 'java'
    gem 'qless', '0.10.0' # Newer releases require `rusage`, which is not available for JRuby
    gem 'redis', '< 4' # Missing redis version cap for `qless`
  else
    gem 'qless', '0.12.0'
  end
end

appraise 'core-old' do
  gem 'dogstatsd-ruby', '~> 4'
end
