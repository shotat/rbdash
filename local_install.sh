#!/bin/sh
gem_name='rbdash'
version=$(grep VERSION lib/rbdash/version.rb | grep -Eo '\d+\.\d+.\d+')
rake build
gem install "pkg/${gem_name}-${version}.gem"
