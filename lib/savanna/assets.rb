require "sass"
require 'coffee-script'
require "compass"
require "sprockets"
require "sprockets-sass"
require "sprockets-helpers"

class Savanna::Assets
  attr_accessor :sprockets

  def initialize
    @sprockets = Sprockets::Environment.new { |env| env.logger = Logger.new(STDOUT) }

    @sprockets.append_path "assets/javascripts"
    @sprockets.append_path "assets/images"
    @sprockets.append_path "assets/stylesheets"

    @sprockets.append_path "vendor/assets/javascripts"
    @sprockets.append_path "vendor/assets/images"
    @sprockets.append_path "vendor/assets/stylesheets"

    Sprockets::Helpers.configure do |config|
      config.environment = @sprockets
      config.prefix      = "/assets"
      config.digest      = false
    end

  end
end