# frozen_string_literal: true

require_relative 'helpers/class_shared_examples'
require 'rspec-puppet-utils'
require 'rspec-puppet-facts'
include RspecPuppetFacts # rubocop:disable Style/MixinUsage

def fixture_path
  File.expand_path(File.join(__FILE__, '..', 'fixtures'))
end

$LOAD_PATH.unshift(File.expand_path("#{File.dirname(__FILE__)}/../"))

RSpec.configure do |c|
  c.mock_with :rspec
end
require 'puppetlabs_spec_helper/module_spec_helper'

RSpec.configure do |c|
  c.add_setting :fixture_path, default: fixture_path
  # c.mock_with(:rspec)
  c.hiera_config = File.join(fixture_path, '/hiera/hiera.yaml')
end
