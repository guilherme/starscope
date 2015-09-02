require 'minitest/autorun'
require 'minitest/pride'
require 'mocha/mini_test'
require File.expand_path('../../lib/starscope.rb', __FILE__)

FIXTURES = 'test/fixtures'

GOLANG_SAMPLE = "#{FIXTURES}/sample_golang.go"
JAVASCRIPT_SAMPLE = "#{FIXTURES}/sample_javascript.js"
RUBY_SAMPLE = "#{FIXTURES}/sample_ruby.rb"
ERB_SAMPLE = "#{FIXTURES}/sample_erb.erb"
EMPTY_FILE = "#{FIXTURES}/empty"
