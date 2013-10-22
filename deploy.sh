#!/bin/sh

git push origin master
heroku run rake db:migrate assets:precompile