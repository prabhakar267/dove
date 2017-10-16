task default: :run

desc 'install requirements'
task :install do
  sh 'gem install bundler --conservative'
  sh 'bundle check || bundle install'
end

desc 'run service'
task :run do
  sh 'bundle exec ruby service.rb'
end
