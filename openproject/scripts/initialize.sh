#!/bin/bash
#initialize db

cd ~/openproject
bundle exec rake db:migrate && \
bundle exec rake db:seed && \
bundle exec rake assets:precompile
