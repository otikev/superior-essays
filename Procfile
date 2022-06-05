web: bundle exec puma -C config/puma.rb
worker: bundle exec crono -e $RAILS_ENV
delayedjobworker: bundle exec rake jobs:work RAILS_ENV=$RAILS_ENV

