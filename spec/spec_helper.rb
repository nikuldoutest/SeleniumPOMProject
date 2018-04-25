require 'rspec'
require 'rubygems'
require 'selenium-webdriver'
require 'bundler'
require 'rspec/retry'
#require_relative '../lib/login_credentials'

Dir['./spec/helpers/**/*.rb'].each { |file| require file }

Bundler.require(:test_frameworks, :test_harness, :libraries, :debugging)

RSpec.configure do |config|

  config.before(:each) do |example|
    # default browser is chrome; others can passed as variables
      case ENV['browser'] ||= 'firefox'
      when 'chrome'
        @driver = Selenium::WebDriver.for :chrome
      when 'firefox'
        @driver = Selenium::WebDriver.for :firefox
      end

      @base_url = 'http://www.poets.org'
      @driver.get @base_url

    end

  config.before(:each) do
    @driver.manage.delete_all_cookies
  end

  config.after(:each) do |example|
    #Screenshoot on example failure
    if example.exception
      @driver.save_screenshot("Failed_screenshot-#{DateTime}.png") #You can append folder path to file name
    end

    @driver.quit
  end
end
